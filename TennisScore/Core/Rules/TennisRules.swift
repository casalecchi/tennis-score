//
//  Game.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 27/07/25.
//

import Foundation

protocol TennisRules {
    func scorePoint(state: inout GameState, to side: Side)
    func scoreTiebreakPoint(state: inout GameState, to side: Side)
}

struct DefaultTennisRules: TennisRules {
    func scorePoint(state: inout GameState, to side: Side) {
        guard !state.isOver else { return }
        
        var (p, o) = players(for: side, in: state)
        
        switch (p.points, o.points) {
        case (.love, _): p.points = .fifteen
        case (.fifteen, _): p.points = .thirty
        case (.thirty, _): p.points = .forty
        case (.forty, .forty): p.points = .advantage
        case (.forty, .advantage): o.points = .forty
        case (.forty, .love), (.forty, .fifteen), (.forty, .thirty), (.advantage, _):
            gameWon(state: &state, by: side)
            return
        }
        
        writeBack(&state, side, p, o)
    }
    
    func scoreTiebreakPoint(state: inout GameState, to side: Side) {
        guard !state.isOver else { return }
        
        var (p, o) = players(for: side, in: state)
        
        let isSuper = (p.sets == 2 && o.sets == 2) && state.config.totalSets == 5
        let winScore = isSuper ? 10 : 7
        
        p.tiebreakScore += 1
        
        // troca de saque - troca a cada ponto ímpar
        if (p.tiebreakScore + o.tiebreakScore) % 2 == 1 {
            state.serveSide = state.serveSide == .a ? .b : .a
        }
        
        if p.tiebreakScore - o.tiebreakScore >= 2 && p.tiebreakScore >= winScore {
            p.tiebreakScore = 0
            o.tiebreakScore = 0
            writeBack(&state, side, p, o)
            gameWon(state: &state, by: side)
            return
        }
        
        writeBack(&state, side, p, o)
    }
    
    private func gameWon(state: inout GameState, by side: Side) {
        var (p, o) = players(for: side, in: state)
        
        p.points = .love
        o.points = .love
        p.games += 1
        state.serveSide = state.serveSide == .a ? .b : .a
        
        // venceu set?
        if (p.games == 6 && o.games < 5) || p.games == 7 {
            p.history.append(SetHistory(score: p.games, winner: true))
            o.history.append(SetHistory(score: o.games, winner: false))
            p.games = 0
            o.games = 0
            p.sets += 1
            
            let setsToWin = (state.config.totalSets / 2) + 1
            if p.sets == setsToWin {
                writeBack(&state, side, p, o)
                state.isOver = true
                return
            }
        }
        
        writeBack(&state, side, p, o)
    }
    
    private func players(for side: Side, in state: GameState) -> (Player, Player) {
        side == .a ? (state.playerA, state.playerB) : (state.playerB, state.playerA)
    }
    
    private func writeBack(_ state: inout GameState, _ side: Side, _ p: Player, _ o: Player) {
        if side == .a {
            state.playerA = p
            state.playerB = o
        } else {
            state.playerB = p
            state.playerA = o
        }
    }
}
