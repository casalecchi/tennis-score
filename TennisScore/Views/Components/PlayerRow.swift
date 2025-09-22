//
//  PlayerRow.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import SwiftUI

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
                .foregroundStyle(.textPrimary)
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
