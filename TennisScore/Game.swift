//
//  Game.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 27/07/25.
//

import SwiftUI

enum Point: Equatable {
    case love, fifteen, thirty, forty, advantage
}

enum Side { case a, b }

enum Tab: Hashable { case home, score }

struct SetHistory: Identifiable {
    let id = UUID()
    let score: Int
    let winner: Bool
}

struct Player: Identifiable {
    let id = UUID()
    let name: String
    var points: Point = .love
    var games = 0
    var sets = 0
    var tiebreakScore = 0
    var history: [SetHistory] = []
    
    var labelPoints: String { Self.label(for: points) }
    var labelTiebreak: String { "\(tiebreakScore)" }
    
    static func label(for point: Point) -> String {
        switch point {
        case .love: return "00"
        case .fifteen: return "15"
        case .thirty: return "30"
        case .forty: return "40"
        case .advantage: return "AD"
        }
    }
}


struct TennisGame {
    var playerA: Player
    var playerB: Player
    
    var serveSide: Side
    
    var totalSets: Int
    
    var isDeuce: Bool { playerA.points == .forty && playerB.points == .forty }
    var isOver = false
    var isTiebreak: Bool { playerA.games == 6 && playerB.games == 6 }
    
    mutating func point(to side: Side) {
        guard !isOver else { return }
        var (player, opponent) = side == .a ? (playerA, playerB) : (playerB, playerA)
        
        switch (player.points, opponent.points) {
        case (.love, _): player.points = .fifteen
        case (.fifteen, _): player.points = .thirty
        case (.thirty, _): player.points = .forty
        case (.forty, .forty): player.points = .advantage
        case (.forty, .advantage): opponent.points = .forty
        case (.forty, .love), (.forty, .fifteen), (.forty, .thirty),
            (.advantage, _):
            game(to: side)
            return
        }
        
        write(player, opponent, side)
    }
    
    mutating func tiebreakPoint(to side: Side) {
        var (player, opponent) = side == .a ? (playerA, playerB) : (playerB, playerA)
        
        let superTiebreak = player.sets == 2 && opponent.sets == 2
        let winScore = superTiebreak ? 10 : 7
        
        player.tiebreakScore += 1
        
        if (player.tiebreakScore + opponent.tiebreakScore) % 2 == 1 {
            changeServer()
        }
        
        if player.tiebreakScore - opponent.tiebreakScore >= 2 && player.tiebreakScore >= winScore  {
            player.tiebreakScore = 0
            opponent.tiebreakScore = 0
            write(player, opponent, side)
            game(to: side)
            return
        }
        
        write(player, opponent, side)
    }
    
    mutating func game(to side: Side) {
        var (player, opponent) = side == .a ? (playerA, playerB) : (playerB, playerA)
        
        player.points = .love
        opponent.points = .love
        player.games += 1
        changeServer()
        
        if (player.games == 6 && opponent.games < 5) || player.games == 7 {
            write(player, opponent, side)
            set(to: side)
            return
        }
        
        write(player, opponent, side)
    }
    
    mutating func set(to side: Side) {
        var (player, opponent) = side == .a ? (playerA, playerB) : (playerB, playerA)
        
        player.history.append(SetHistory(score: player.games, winner: true))
        opponent.history.append(SetHistory(score: opponent.games, winner: false))
        player.games = 0
        opponent.games = 0
        player.sets += 1
        
        if player.sets == Int(totalSets / 2) + 1 {
            write(player, opponent, side)
            end()
        }
        
        write(player, opponent, side)
    }
    
    mutating func end() {
        isOver = true
    }
    
    private mutating func changeServer() {
        serveSide = serveSide == .a ? .b : .a
    }
    
    private mutating func write(_ player: Player, _ opponent: Player, _ side: Side) {
        if side == .a {
            playerA = player
            playerB = opponent
        } else {
            playerB = player
            playerA = opponent
        }
    }
}

