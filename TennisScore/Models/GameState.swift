//
//  GameState.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import Foundation

struct GameState {
    var playerA: Player
    var playerB: Player
    var serveSide: Side
    var isOver = false
    let config: GameConfig
    
    var isDeuce: Bool { playerA.points == .forty && playerB.points == .forty }
    var isTiebreak: Bool { playerA.games == 6 && playerB.games == 6 }
}

struct GameConfig {
    let totalSets: Int
}
