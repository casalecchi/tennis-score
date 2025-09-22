//
//  PointPad.swift
//  TennisScore
//
//  Created by Felipe Casalecchi on 21/09/25.
//

import SwiftUI

struct PointPad: View {
    let title: String
    let onTap: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .foregroundStyle(.textPrimary)
            Spacer()
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundStyle(Color.accentColor)
                Text("Tap to score")
                    .foregroundStyle(.textPrimary)
            }
            .font(.caption)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.scoreboardBackground)))
        .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.white.opacity(0.25), lineWidth: 1))
        .onTapGesture { onTap() }
    }
}
