import ReplayKit

/// Fernwartung ReplayKit broadcast upload extension.
///
/// Captures the whole iOS screen and streams the frames to the main app through
/// a Unix-domain socket in the shared app-group container. The main app
/// (flutter_webrtc's FlutterBroadcastScreenCapturer) reads them and feeds them
/// into the WebRTC video track so the Vorsitzer sees the member's screen.
///
/// The app group + socket name MUST match the main app:
///   app group : group.de.icd360s.icd360sevMitglied
///   socket    : rtc_SSFD   (flutter_webrtc's kRTCScreensharingSocketFD)
class SampleHandler: RPBroadcastSampleHandler {
    private static let appGroupIdentifier = "group.de.icd360s.icd360sevMitglied"

    private var clientConnection: SocketConnection?
    private var uploader: SampleUploader?

    private var socketFilePath: String {
        let container = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: SampleHandler.appGroupIdentifier)
        return container?.appendingPathComponent("rtc_SSFD").path ?? ""
    }

    override func broadcastStarted(withSetupInfo setupInfo: [String: NSObject]?) {
        DarwinNotificationCenter.shared.postNotification(.broadcastStarted)
        openConnection()
    }

    override func broadcastPaused() {}
    override func broadcastResumed() {}

    override func broadcastFinished() {
        clientConnection?.close()
        DarwinNotificationCenter.shared.postNotification(.broadcastStopped)
    }

    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer,
                                      with sampleBufferType: RPSampleBufferType) {
        if sampleBufferType == .video {
            uploader?.send(sample: sampleBuffer)
        }
    }

    private func openConnection() {
        let connection = SocketConnection(filePath: socketFilePath)
        clientConnection = connection
        connection.didClose = { [weak self] error in
            let err = error ?? NSError(domain: "Fernwartung.Broadcast", code: 0,
                                       userInfo: [NSLocalizedDescriptionKey: "Broadcast beendet"])
            self?.finishBroadcastWithError(err)
        }
        uploader = SampleUploader(connection: connection)
        connection.open()
    }
}
