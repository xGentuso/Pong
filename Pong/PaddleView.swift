

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

