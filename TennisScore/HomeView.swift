import SwiftUI

struct HomeView: View {
    @State private var sets: Int = 0
    @State var firstServer: Side = .a
    @State var playerA = "Player 1"
    @State var playerB = "Player 2"
    @State var totalSets = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                PlayersCard(playerA: $playerA, playerB: $playerB)
                HStack {
                    SetCard(totalSets: $totalSets)
                    ServeCard(server: $firstServer, playerA: $playerA, playerB: $playerB)
                }
                Spacer()
                PlayButton()
            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}

struct PlayersCard: View {
    @State private var isEditing = false
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
                                Button {
                                    isEditing = false
                                } label: {
                                    Image(systemName: "checkmark")
                                        .font(.title)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            Text(playerA)
                                .font(.title2)
                            Text(playerB)
                                .font(.title2)
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
    @State private var isEditing = false
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
                                Button {
                                    withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                                        isEditing = false
                                    }
                                } label: {
                                    Image(systemName: "checkmark")
                                        .font(.title)
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
                    .contentShape(Rectangle()) // define área de toque
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
    @State private var isEditing = false
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
                                
                                Button {
                                    withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                                        isEditing = false
                                    }
                                } label: {
                                    Image(systemName: "checkmark")
                                        .font(.title)
                                }
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
                    .contentShape(Rectangle()) // define área de toque
                    .onTapGesture {
                        withAnimation(.spring(response: 0.28, dampingFraction: 0.85)) {
                            isEditing = true
                        }
                    }
            }
        }
    }
}

struct PlayButton: View {
    var body: some View {
        NavigationLink {
            ContentView()
        } label: {
            Label("Play Match", systemImage: "play.fill")
                .font(.headline)
                .padding(.horizontal, 22).padding(.vertical, 14)
        }
        .background(Color.background, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(.white.opacity(0.45), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.25), radius: 18, y: 14)
    }
}

#Preview {
    HomeView()
}

//import SwiftUI
//
//struct Match: Identifiable, Hashable {
//    let id = UUID()
//    let opponent: String
//    let date: Date
//}
//
//struct HomeView: View {
//    @State private var matches: [Match] = [
//        .init(opponent: "João", date: .now),
//        .init(opponent: "Ana",  date: .now.addingTimeInterval(-86400)),
//        .init(opponent: "Rafa", date: .now.addingTimeInterval(-86400)),
//    ]
//    @State private var goToNewMatch = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .bottomTrailing) {
//                VStack(alignment: .leading, spacing: 12) {
//                    // Cabeçalho fixo
//                    HStack(spacing: 12) {
//                        Circle()
//                            .fill(.gray.opacity(0.3))
//                            .frame(width: 40, height: 40)
//                            .overlay(Image(systemName: "person.fill").foregroundStyle(.primary))
//                        VStack(alignment: .leading, spacing: 2) {
//                            Text("My matches").font(.title3).bold()
//                            Text("\(matches.count) game\(matches.count == 1 ? "" : "s")")
//                                .font(.subheadline).foregroundStyle(.secondary)
//                        }
//                        Spacer()
//                    }
//                    .padding(.horizontal)
//
//                    // Lista rolável
//                    ScrollView {
//                        LazyVStack(spacing: 12) {
//                            ForEach(matches) { m in
//                                NavigationLink(value: m) {
//                                    MatchRow(match: m)
//                                }
//                                .buttonStyle(.plain)
//                                .padding(.horizontal)
//                            }
//                        }
//                        .padding(.bottom, 88) // espaço pro FAB
//                    }
//                }
//
//                // Botão flutuante → PUSH para NewMatchView
//                Button {
//                    goToNewMatch = true
//                } label: {
//                    Label("New match", systemImage: "plus")
//                        .font(.headline)
//                        .padding(.horizontal, 16).padding(.vertical, 12)
//                        .background(.accent)
//                        .foregroundStyle(.black)
//                        .clipShape(Capsule())
//                        .shadow(radius: 6, y: 3)
//                }
//                .padding(.trailing, 20)
//                .padding(.bottom, 24)
//
//                // NavigationLink programático (sem aparecer na UI)
//                NavigationLink(
//                    destination: NewMatchView { newMatch in
//                        matches.insert(newMatch, at: 0)
//                    },
//                    isActive: $goToNewMatch
//                ) { EmptyView() }
//                .hidden()
//            }
//            .navigationTitle("")              // sem barra padrão
//            .navigationBarHidden(true)
//            .background(Color.background.ignoresSafeArea())
//            // destino para tocar numa partida existente (detalhe)
//            .navigationDestination(for: Match.self) { m in
//                MatchDetailView(match: m)
//            }
//        }
//    }
//}
//
//struct MatchRow: View {
//    let match: Match
//    var body: some View {
//        HStack {
//            Image(systemName: "tennisball.fill")
//            VStack(alignment: .leading) {
//                Text(match.opponent).bold()
//                Text(match.date.formatted(date: .abbreviated, time: .omitted))
//                    .font(.caption).foregroundStyle(.secondary)
//            }
//            Spacer()
//            Image(systemName: "chevron.right")
//                .font(.footnote).foregroundStyle(.secondary)
//        }
//        .padding(12)
//        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
//    }
//}
//
//struct NewMatchView: View {
//    var onSave: (Match) -> Void
//    @Environment(\.dismiss) private var dismiss
//    @State private var opponent = ""
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("New Match").font(.title2).bold()
//            TextField("Opponent", text: $opponent)
//                .textFieldStyle(.roundedBorder)
//            Button("Save") {
//                onSave(.init(opponent: opponent.isEmpty ? "Unknown" : opponent, date: .now))
//                dismiss()                     // volta (pop) na stack
//            }
//            .buttonStyle(.borderedProminent)
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("New Match")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//struct MatchDetailView: View {
//    let match: Match
//    var body: some View {
//        Text("Detalhe: \(match.opponent)")
//            .navigationTitle("Match")
//            .navigationBarTitleDisplayMode(.inline)
//    }
//}
