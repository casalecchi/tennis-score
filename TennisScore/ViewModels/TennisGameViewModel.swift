//
//  TennisGameViewModel.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import Foundation
import Combine

final class TennisGameViewModel: ObservableObject {
    // Estado publicado para a UI
    @Published private(set) var state: GameState
    @Published private(set) var stopwatchText: String = "00:00"
    @Published private(set) var stopwatchRunning: Bool = false
    
    // Dependências
    private let rules: TennisRules
    private let stopwatch: StopwatchService
    
    private var bag = Set<AnyCancellable>()
    
    init(
        playerAName: String,
        playerBName: String,
        serveSide: Side,
        totalSets: Int = 3,
        rules: TennisRules = DefaultTennisRules(),
        stopwatch: StopwatchService = StopwatchService()
    ) {
        self.rules = rules
        self.stopwatch = stopwatch
        self.state = GameState(
            playerA: Player(name: playerAName),
            playerB: Player(name: playerBName),
            serveSide: serveSide,
            isOver: false,
            config: GameConfig(totalSets: totalSets)
        )
        
        // Bind stopwatch para propriedades publicadas
        stopwatch.$elapsed
            .map { elapsed -> String in
                let t = Int(elapsed)
                let m = t / 60, s = t % 60
                return String(format: "%02d:%02d", m, s)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$stopwatchText)
        
        stopwatch.$isRunning
            .receive(on: DispatchQueue.main)
            .assign(to: &$stopwatchRunning)
        
        stopwatch.start()
    }
    
    // MARK: Intents (entrada da View)
    
    func toggleStopwatch() {
        stopwatchRunning ? stopwatch.pause() : stopwatch.resume()
    }
    
    func tap(side: Side) {
        state.isTiebreak
        ? rules.scoreTiebreakPoint(state: &state, to: side)
        : rules.scorePoint(state: &state, to: side)
    }
    
    // Exposições convenientes para a View (evita mexer no state bruto)
    var isOver: Bool { state.isOver }
    var isTiebreak: Bool { state.isTiebreak }
    var serveSide: Side { state.serveSide }
    var playerA: Player { state.playerA }
    var playerB: Player { state.playerB }
}
