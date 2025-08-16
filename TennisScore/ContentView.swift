//
//  ContentView.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 24/07/25.
//

import SwiftUI

struct ContentView: View {
    @State var game: TennisGame
    
    var body: some View {
        ZStack {
            Color.scoreboardBackground.ignoresSafeArea()
            VStack {
                ZStack {
                    Image(systemName: "pause")
                        .font(.title2)
                        .fontWeight(.bold)
                    HStack {
                        Spacer()
                        Text("1:10")
                            .font(.system(.title, design: .monospaced))
                    }
                }
                .padding(.bottom)
                VStack(spacing: 1) {
                    PlayerRow(player: game.playerA, isServing: game.serveSide == .a, gameEnded: game.isOver)
                    Divider()
                    PlayerRow(player: game.playerB, isServing: game.serveSide == .b, gameEnded: game.isOver)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.scoreboardBackground))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.25), lineWidth: 2))
                Spacer()
                ZStack {
                    Text("x")
                        .font(.system(size: 48))
                    HStack {
                        ScoreText(label: game.isTiebreak ? game.playerA.labelTiebreak : game.playerA.labelPoints)
                        ScoreText(label: game.isTiebreak ? game.playerB.labelTiebreak : game.playerB.labelPoints)
                    }
                }
                Spacer()
                HStack {
                    PointPad(game: $game, side: .a)
                    PointPad(game: $game, side: .b)
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PlayerRow: View {
    let player: Player
    let isServing: Bool
    let gameEnded: Bool
    
    var body: some View {
        HStack {
            if !gameEnded {
                Image(systemName: "circle.fill")
                    .font(.system(size: 8))
                    .foregroundStyle(isServing ? .accent : .scoreboardBackground)
            }
            Text(player.name)
                .font(.system(size: 24, weight: .heavy, design: .default))
                .kerning(1)
                .textCase(.uppercase)
                .foregroundStyle(Color.white)
            Spacer()
            HStack(spacing: 3) {
                ForEach(player.history) { history in
                    Text("\(history.score)")
                        .monospacedDigit()
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .font(.title)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .background(Rectangle().fill(history.winner ? Color.setWinner : Color.scoreboardBackground))
                        .foregroundStyle(history.winner ? Color.accent : Color.customGray)
                }
                if !gameEnded {
                    Text("\(player.games)")
                        .monospacedDigit()
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .font(.title)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                        .background(Rectangle().fill(Color.accentColor))
                        .foregroundStyle(Color.scoreboardBackground)
                }
            }
        }
        .animation(.spring(response: 0.28, dampingFraction: 0.85), value: player.games)
        .animation(.spring(response: 0.28, dampingFraction: 0.85), value: player.sets)
    }
}



struct ScoreText: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.system(size: 64))
            .fontWeight(.bold)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.background)))
            .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.primary.opacity(0.25), lineWidth: 1))
            .frame(maxWidth: .infinity)
    }
}

struct PointPad: View {
    @Binding var game: TennisGame
    let side: Side
    
    var body: some View {
        VStack {
            Text(side == .a ? game.playerA.name : game.playerB.name)
            Spacer()
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundStyle(Color.accentColor)
                Text("Tap to score")
            }
            .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.background)))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.primary.opacity(0.25), lineWidth: 1))
        .onTapGesture {
            game.isTiebreak ? game.tiebreakPoint(to: side) : game.point(to: side)
        }
    }
}

#Preview {
    ContentView(game: TennisGame(playerA: Player(name: "Felipe"), playerB: Player(name: "Camila"), serveSide: .a, totalSets: 3))
}
