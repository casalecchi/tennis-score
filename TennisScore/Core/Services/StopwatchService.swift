//
//  Stopwatch.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 23/08/25.
//

import Foundation
import Combine

final class StopwatchService {
    @Published private(set) var isRunning = false
    @Published private(set) var elapsed: TimeInterval = 0
    
    private var timer: AnyCancellable?
    private var startDate: Date?
    
    var formatted: String {
        let t = Int(elapsed)
        let h = t / 3600, m = (t % 3600) / 60, s = t % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self, let start = self.startDate else { return }
                self.elapsed = Date().timeIntervalSince(start)
            }
    }
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        startDate = Date()
        startTimer()
    }
    
    func pause() {
        isRunning = false
        timer?.cancel()
    }
    
    func resume() {
        guard !isRunning else { return }
        isRunning = true
        startDate = Date().addingTimeInterval(-elapsed)
        startTimer()
    }
}
