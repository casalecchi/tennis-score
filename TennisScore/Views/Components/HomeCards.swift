//
//  HomeCards.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import SwiftUI

struct PlayersCard: View {
    @Binding var isEditing: Bool
    @Binding var playerA: String
    @Binding var playerB: String

    var body: some View {
        Card {
            VStack(alignment: .leading) {
                Text("Players")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                HStack(alignment: .bottom, spacing: 12) {
                    Image(systemName: "person.fill")
                        .font(.largeTitle)
                    Spacer()
                    VStack(alignment: .leading, spacing: 12) {
                        if isEditing {
                            HStack {
                                VStack(alignment: .trailing) {
                                    TextField("Tap the name of Player 1", text: $playerA)
                                        .textFieldStyle(.roundedBorder)
                                    TextField("Tap the name of Player 2", text: $playerB)
                                        .textFieldStyle(.roundedBorder)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            Text(playerA).font(.title2)
                            Text(playerB).font(.title2)
                        }
                    }
                }
            }
        }
        .onTapGesture {
            if !isEditing {
                withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                    isEditing = true
                }
            }
        }
    }
}

struct SetCard: View {
    @Binding var isEditing: Bool
    @Binding var totalSets: Int

    var body: some View {
        Card {
            VStack(alignment: .leading) {
                Text("Sets")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                HStack(alignment: .bottom, spacing: 12) {
                    Image(systemName: "tennisball.fill")
                        .font(.title)
                    Spacer()
                    VStack(alignment: .leading, spacing: 12) {
                        if isEditing {
                            HStack {
                                VStack {
                                    Text("\(totalSets)")
                                        .font(.largeTitle)
                                    Stepper("teste", value: $totalSets, in: 1...7, step: 2)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            Text("\(totalSets)")
                                .font(.largeTitle)
                        }
                    }
                }
            }
        }
        .overlay {
            if !isEditing {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                            isEditing = true
                        }
                    }
            }
        }
    }
}

struct ServeCard: View {
    @Binding var isEditing: Bool
    @Binding var server: Side
    @Binding var playerA: String
    @Binding var playerB: String

    var body: some View {
        Card {
            VStack(alignment: .leading) {
                Text("First Server")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
                HStack(alignment: .bottom, spacing: 12) {
                    Image(systemName: "figure.tennis")
                        .font(.title)
                    Spacer()
                    VStack(alignment: .leading, spacing: 12) {
                        if isEditing {
                            HStack(alignment: .bottom) {
                                Picker("Text", selection: $server) {
                                    Text(playerA).tag(Side.a)
                                    Text(playerB).tag(Side.b)
                                }
                                .pickerStyle(.wheel)
                            }
                        } else {
                            Text(server == .a ? playerA : playerB)
                                .font(.title2)
                        }
                    }
                }
            }
        }
        .layoutPriority(isEditing ? 1 : 0)
        .overlay {
            if !isEditing {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                            isEditing = true
                        }
                    }
            }
        }
    }
}

// MARK: - PlayButton cria o ViewModel e navega
struct PlayButton: View {
    let playerA: String
    let playerB: String
    let sets: Int
    let firstServer: Side

    var body: some View {
        NavigationLink {
            // cria o VM com dependências do Core
            MatchView(
                vm: TennisGameViewModel(
                    playerAName: playerA,
                    playerBName: playerB,
                    serveSide: firstServer,
                    totalSets: sets,
                    rules: DefaultTennisRules(),
                    stopwatch: StopwatchService()
                )
            )
        } label: {
            Label("Play Match", systemImage: "play.fill")
                .font(.headline)
                .padding(.horizontal, 22)
                .padding(.vertical, 14)
        }
        .background(Color.background, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(.white.opacity(0.45), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.25), radius: 18, y: 14)
    }
}
