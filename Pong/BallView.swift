//
//  BallView.swift
//  Pong
//
//  Created by ryan mota on 2025-03-18.
//

import SwiftUI

struct BallView: View {
    let position: CGPoint
    
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 20)
            .position(position)
    }
}
