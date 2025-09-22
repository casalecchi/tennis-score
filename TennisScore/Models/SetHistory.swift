//
//  SetHistory.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import Foundation

struct SetHistory: Identifiable {
    let id = UUID()
    let score: Int
    let winner: Bool
}
