//
//  ContentView.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 24/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm: TennisGameViewModel

    init(vm: TennisGameViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        ZStack {
            Color.scoreboardBackground.ignoresSafeArea()
            VStack {
                // Stopwatch / Header
                ZStack {
                    Image(systemName: vm.stopwatchRunning ? "pause" : "play")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.textPrimary)
                        .onTapGesture { vm.toggleStopwatch() }

                    HStack {
                        Spacer()
                        Text(vm.stopwatchText)
                            .font(.system(.title, design: .monospaced))
                            .foregroundStyle(.textPrimary)
                    }
                }
                .padding(.bottom)

                if vm.isOver {
                    Spacer()
                }

                // Players rows
                VStack(spacing: 1) {
                    PlayerRow(player: vm.playerA, isServing: vm.serveSide == .a, gameEnded: vm.isOver)
                    Divider()
                    PlayerRow(player: vm.playerB, isServing: vm.serveSide == .b, gameEnded: vm.isOver)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.scoreboardBackground))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.25), lineWidth: 2))

                if !vm.isOver {
                    Spacer()
                    ZStack {
                        Text("x")
                            .font(.system(size: 48))
                            .foregroundStyle(.textPrimary)
                        HStack {
                            ScoreText(label: vm.isTiebreak ? vm.playerA.labelTiebreak : vm.playerA.labelPoints)
                            ScoreText(label: vm.isTiebreak ? vm.playerB.labelTiebreak : vm.playerB.labelPoints)
                        }
                    }
                }

                Spacer()

                // Point pads (sem referência direta ao VM, só closures)
                HStack {
                    PointPad(
                        title: vm.playerA.name,
                        onTap: { vm.tap(side: .a) }
                    )
                    PointPad(
                        title: vm.playerB.name,
                        onTap: { vm.tap(side: .b) }
                    )
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .animation(.spring(response: 0.28, dampingFraction: 0.85), value: vm.isOver)
        }
    }
}

#Preview {
    ContentView(
        vm: TennisGameViewModel(
            playerAName: "Felipe",
            playerBName: "Camila",
            serveSide: .a,
            totalSets: 3,
            rules: DefaultTennisRules(),
            stopwatch: StopwatchService()
        )
    )
}
