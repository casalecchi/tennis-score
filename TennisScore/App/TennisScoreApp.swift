//
//  TennisScoreApp.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 24/07/25.
//

import SwiftUI

@main
struct TennisScoreApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
