//
//  ScoreText.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import SwiftUI

struct ScoreText: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.system(size: 64))
            .fontWeight(.bold)
            .foregroundStyle(.textPrimary)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.scoreboardBackground)))
            .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.white.opacity(0.25), lineWidth: 1))
            .frame(maxWidth: .infinity)
    }
}
