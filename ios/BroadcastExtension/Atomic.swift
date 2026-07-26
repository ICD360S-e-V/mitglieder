import Foundation

/// Small thread-safe box used by the socket uploader.
final class Atomic<A> {
    private let queue = DispatchQueue(label: "fernwartung.atomic")
    private var _value: A

    init(_ value: A) {
        self._value = value
    }

    var value: A {
        return queue.sync { self._value }
    }

    func mutate(_ transform: (inout A) -> Void) {
        queue.sync { transform(&self._value) }
    }
}
