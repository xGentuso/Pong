//
//  PaddleView.swift
//  Pong
//
//  Created by ryan mota on 2025-03-18.
//

import SwiftUI

struct PaddleView: View {
    let position: CGPoint
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(width: width, height: height)
            .position(position)
    }
}

