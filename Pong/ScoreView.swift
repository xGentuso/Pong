//
//  ScoreView.swift
//  Pong
//
//  Created by ryan mota on 2025-03-18.
//

import SwiftUI

struct ScoreView: View {
    let playerScore: Int
    let computerScore: Int
    
    var body: some View {
        HStack {
            Text("\(playerScore)")
                .font(.largeTitle)
                .foregroundStyle(.white)
            Spacer()
            Text("\(computerScore)")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
        .padding(40)
    }
}
