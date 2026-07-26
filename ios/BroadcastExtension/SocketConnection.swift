import Foundation

/// Extension-side Unix-domain-socket CLIENT. Connects to the socket the main app
/// (FlutterSocketConnection) created in the shared app-group container, and
/// streams framed frames to it. Canonical flutter_webrtc broadcast helper.
class SocketConnection: NSObject {
    var didOpen: (() -> Void)?
    var didClose: ((Error?) -> Void)?
    var streamHasSpaceAvailable: (() -> Void)?

    private let filePath: String
    private var socketHandle: Int32 = -1
    private var address: sockaddr_un?

    private var inputStream: InputStream?
    private var outputStream: OutputStream?

    private var networkQueue: DispatchQueue?
    private var shouldKeepRunning = false

    init(filePath path: String) {
        filePath = path
        socketHandle = Darwin.socket(AF_UNIX, SOCK_STREAM, 0)
        super.init()

        guard setupAddress() == true else { return }
    }

    func open() {
        guard FileManager.default.fileExists(atPath: filePath) else {
            didClose?(SocketError.unableToConnect)
            return
        }
        guard connectSocket() == true else {
            didClose?(SocketError.unableToConnect)
            return
        }

        setupStreams()
        inputStream?.open()
        outputStream?.open()
    }

    func close() {
        unscheduleStreams()

        inputStream?.delegate = nil
        outputStream?.delegate = nil

        inputStream?.close()
        outputStream?.close()

        inputStream = nil
        outputStream = nil
    }

    func writeToStream(buffer: UnsafePointer<UInt8>, maxLength length: Int) -> Int {
        return outputStream?.write(buffer, maxLength: length) ?? 0
    }
}

extension SocketConnection: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .openCompleted:
            didOpen?()
        case .hasSpaceAvailable:
            streamHasSpaceAvailable?()
        case .errorOccurred:
            close()
            didClose?(aStream.streamError)
        case .endEncountered:
            close()
            didClose?(nil)
        default:
            break
        }
    }
}

private extension SocketConnection {
    func setupAddress() -> Bool {
        var addr = sockaddr_un()
        guard filePath.count < MemoryLayout.size(ofValue: addr.sun_path) else {
            return false
        }
        addr.sun_family = sa_family_t(AF_UNIX)
        _ = withUnsafeMutablePointer(to: &addr.sun_path.0) { ptr in
            filePath.withCString { cstr in
                strncpy(ptr, cstr, filePath.count)
            }
        }
        address = addr
        return true
    }

    func connectSocket() -> Bool {
        guard var addr = address else { return false }
        let status = withUnsafePointer(to: &addr) { ptr in
            ptr.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockPtr in
                Darwin.connect(socketHandle, sockPtr, socklen_t(MemoryLayout<sockaddr_un>.size))
            }
        }
        return status == 0
    }

    func setupStreams() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?

        CFStreamCreatePairWithSocket(kCFAllocatorDefault, socketHandle, &readStream, &writeStream)

        inputStream = readStream?.takeRetainedValue()
        inputStream?.delegate = self
        inputStream?.setProperty(kCFBooleanTrue, forKey: Stream.PropertyKey(kCFStreamPropertyShouldCloseNativeSocket as String))

        outputStream = writeStream?.takeRetainedValue()
        outputStream?.delegate = self
        outputStream?.setProperty(kCFBooleanTrue, forKey: Stream.PropertyKey(kCFStreamPropertyShouldCloseNativeSocket as String))

        scheduleStreams()
    }

    func scheduleStreams() {
        shouldKeepRunning = true
        networkQueue = DispatchQueue.global(qos: .userInitiated)
        networkQueue?.async { [weak self] in
            self?.inputStream?.schedule(in: .current, forMode: .common)
            self?.outputStream?.schedule(in: .current, forMode: .common)
            RunLoop.current.run()
        }
    }

    func unscheduleStreams() {
        networkQueue?.sync { [weak self] in
            self?.inputStream?.remove(from: .current, forMode: .common)
            self?.outputStream?.remove(from: .current, forMode: .common)
        }
        shouldKeepRunning = false
    }
}

enum SocketError: Error {
    case unableToConnect
}
