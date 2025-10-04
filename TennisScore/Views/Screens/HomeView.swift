import SwiftUI

// Views/Screens/HomeView.swift
import SwiftUI

struct HomeView: View {
    @State private var sets: Int = 3
    @State private var firstServer: Side = .a
    @State private var playerA = "Player 1"
    @State private var playerB = "Player 2"

    enum EditingCard { case players, sets, serve }
    @State private var editing: EditingCard? = nil

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            if editing != nil {
                Color.clear
                    .ignoresSafeArea()
                    .contentShape(Rectangle())
                    .onTapGesture { editing = nil }
                    .zIndex(0)
            }
            
            VStack {
                PlayersCard(
                    isEditing: Binding(
                        get: { editing == .players },
                        set: { $0 ? editing = .players : (editing == .players ? editing = nil : ()) }
                    ),
                    playerA: $playerA,
                    playerB: $playerB
                )
                .zIndex(editing == .players ? 1 : 0)

                HStack {
                    SetCard(
                        isEditing: Binding(
                            get: { editing == .sets },
                            set: { $0 ? editing = .sets : (editing == .sets ? editing = nil : ()) }
                        ),
                        totalSets: $sets
                    )
                    .zIndex(editing == .sets ? 1 : 0)

                    ServeCard(
                        isEditing: Binding(
                            get: { editing == .serve },
                            set: { $0 ? editing = .serve : (editing == .serve ? editing = nil : ()) }
                        ),
                        server: $firstServer,
                        playerA: $playerA,
                        playerB: $playerB
                    )
                    .zIndex(editing == .serve ? 1 : 0)
                }

                Spacer()

                PlayButton(
                    playerA: playerA,
                    playerB: playerB,
                    sets: sets,
                    firstServer: firstServer
                )
            }
            .padding()
            .animation(.spring(response: 0.28, dampingFraction: 0.85), value: editing)
        }
        .navigationTitle("Settings")
    }
}


#Preview {
    HomeView()
}
