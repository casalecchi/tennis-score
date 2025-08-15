//
//  ContentView.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 24/07/25.
//

import SwiftUI

struct ContentView: View {
    @State var game = TennisGame(totalSets: 3)
    
    var body: some View {
        VStack {
            HStack {
                ForEach(game.history, id: \.self) { set in
                    VStack {
                        Text("\(set[0])")
                        Text("\(set[1])")}
                }
                if !game.isOver {
                    VStack {
                    Text("\(game.playerA.games)")
                    Text("\(game.playerB.games)")}
                }
                VStack {
                    Text("\(game.playerA.sets)")
                    Text("\(game.playerB.sets)")}
            }
            HStack {
                Spacer()
                ScoreNumber(number: game.isTiebreak ? game.playerA.labelTiebreak : game.playerA.labelPoints)
                    .onTapGesture {
                        game.isTiebreak ? game.tiebreakPoint(to: .a) : game.point(to: .a)
                    }
                Spacer()
                Text("x")
                    .font(.system(size: 30))
                Spacer()
                ScoreNumber(number: game.isTiebreak ? game.playerB.labelTiebreak : game.playerB.labelPoints)
                    .onTapGesture {
                        game.isTiebreak ? game.tiebreakPoint(to: .b) : game.point(to: .b)
                    }
                Spacer()
            }
        }
        .padding()
    }
}

struct ScoreNumber: View {
    var number: String
    var body: some View {
        Text(number)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .border(Color.black)
            .font(.system(size: 64))
            .background(Color.background)
    }
}

#Preview {
    ContentView()
}
