import Foundation
import ReplayKit
import CoreImage
import VideoToolbox

private let kMaxWriteLength = 24 * 1024

/// Serialises each screen frame as an HTTP-framed JPEG message (headers
/// Buffer-Width / Buffer-Height / Buffer-Orientation + Content-Length body) and
/// streams it to the main app over the socket — the exact wire format
/// flutter_webrtc's FlutterSocketConnectionFrameReader expects.
class SampleUploader {
    private static let imageContext = CIContext(options: nil)

    private let connection: SocketConnection

    private var dataToSend: Data?
    private var byteIndex = 0

    private let serialQueue = DispatchQueue(label: "fernwartung.sampleUploader")
    private let isReady = Atomic(false)

    init(connection: SocketConnection) {
        self.connection = connection
        setupConnection()
    }

    @discardableResult
    func send(sample buffer: CMSampleBuffer) -> Bool {
        guard isReady.value else { return false }
        isReady.mutate { $0 = false }

        dataToSend = prepare(sample: buffer)
        byteIndex = 0

        serialQueue.async { [weak self] in
            self?.sendDataChunk()
        }
        return true
    }

    private func setupConnection() {
        connection.streamHasSpaceAvailable = { [weak self] in
            self?.serialQueue.async {
                if let uploader = self, !uploader.sendDataChunk() {
                    uploader.isReady.mutate { $0 = true }
                }
            }
        }
    }

    @discardableResult
    private func sendDataChunk() -> Bool {
        guard let dataToSend = dataToSend else { return false }

        var bytesLeft = dataToSend.count - byteIndex
        var length = min(bytesLeft, kMaxWriteLength)

        length = dataToSend[byteIndex..<(byteIndex + length)].withUnsafeBytes {
            guard let ptr = $0.bindMemory(to: UInt8.self).baseAddress else { return 0 }
            return connection.writeToStream(buffer: ptr, maxLength: length)
        }

        if length > 0 {
            byteIndex += length
            bytesLeft -= length
            if bytesLeft == 0 {
                self.dataToSend = nil
                byteIndex = 0
            }
        }
        return true
    }

    private func prepare(sample buffer: CMSampleBuffer) -> Data? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(buffer) else { return nil }

        let scaleFactor: CGFloat = 1.0
        let width = CGFloat(CVPixelBufferGetWidth(imageBuffer)) * scaleFactor
        let height = CGFloat(CVPixelBufferGetHeight(imageBuffer)) * scaleFactor
        let orientation = CMGetAttachment(buffer, key: RPVideoSampleOrientationKey as CFString,
                                          attachmentModeOut: nil)?.uintValue ?? 0

        guard let messageData = jpegData(from: imageBuffer, width: width, height: height) else {
            return nil
        }

        let httpResponse = CFHTTPMessageCreateResponse(nil, 200, nil, kCFHTTPVersion1_1).takeRetainedValue()
        CFHTTPMessageSetHeaderFieldValue(httpResponse, "Content-Length" as CFString,
                                         String(messageData.count) as CFString)
        CFHTTPMessageSetHeaderFieldValue(httpResponse, "Buffer-Width" as CFString,
                                         String(format: "%.0f", width) as CFString)
        CFHTTPMessageSetHeaderFieldValue(httpResponse, "Buffer-Height" as CFString,
                                         String(format: "%.0f", height) as CFString)
        CFHTTPMessageSetHeaderFieldValue(httpResponse, "Buffer-Orientation" as CFString,
                                         String(orientation) as CFString)
        CFHTTPMessageSetBody(httpResponse, messageData as CFData)

        return CFHTTPMessageCopySerializedMessage(httpResponse)?.takeRetainedValue() as Data?
    }

    private func jpegData(from pixelBuffer: CVPixelBuffer, width: CGFloat, height: CGFloat) -> Data? {
        let image = CIImage(cvPixelBuffer: pixelBuffer)
        guard let colorSpace = image.colorSpace else { return nil }
        let options: [CIImageRepresentationOption: Float] = [
            CIImageRepresentationOption(rawValue: kCGImageDestinationLossyCompressionQuality as String): 0.6
        ]
        return SampleUploader.imageContext.jpegRepresentation(of: image, colorSpace: colorSpace,
                                                              options: options)
    }
}
