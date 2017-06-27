//
// TimeReporter.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

public final class TimeReporter {
    private let onUpdate: (TimeInterval) -> Void
    private let updateInterval: TimeInterval
    private var isActive = false

    // MARK: De/Init
    public init(each interval: TimeInterval, onUpdate: @escaping (TimeInterval) -> Void) {
        self.updateInterval = interval
        self.onUpdate = onUpdate
    }

    deinit {
        self.stop()
    }
}

// MARK: - Updating
extension TimeReporter {
    private func update(from start: Date) {
        guard self.isActive else { return }
        let current = Date()
        let interval = start.timeIntervalSince(current)
        self.onUpdate(interval)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + self.updateInterval) { self.update(from: start) }
    }
}

// MARK: - Start/Stop
extension TimeReporter {
    public func start() {
        self.isActive = true
        self.update(from: Date())
    }

    public func stop() {
        self.isActive = false
    }
}
