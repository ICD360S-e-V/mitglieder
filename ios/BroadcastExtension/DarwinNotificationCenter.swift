import Foundation

enum DarwinNotification: String {
    case broadcastStarted = "iOS_BroadcastStarted"
    case broadcastStopped = "iOS_BroadcastStopped"
}

/// Cross-process (app ⇄ extension) signalling via Darwin notifications.
class DarwinNotificationCenter {
    static let shared = DarwinNotificationCenter()

    private let center: CFNotificationCenter

    private init() {
        center = CFNotificationCenterGetDarwinNotifyCenter()
    }

    func postNotification(_ name: DarwinNotification) {
        CFNotificationCenterPostNotification(
            center,
            CFNotificationName(rawValue: name.rawValue as CFString),
            nil, nil, true)
    }
}
