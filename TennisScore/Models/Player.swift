//
//  Player.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    let name: String
    var points: Point = .love
    var games = 0
    var sets = 0
    var tiebreakScore = 0
    var history: [SetHistory] = []
    
    var labelPoints: String {
        switch points {
        case .love: return "00"
        case .fifteen: return "15"
        case .thirty: return "30"
        case .forty: return "40"
        case .advantage: return "AD"
        }
    }
    
    var labelTiebreak: String { "\(tiebreakScore)" }
}
