//
//  ContentView.swift
//  Pong
//
//  Created by ryan mota on 2025-03-18.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameEngine = GameEngine()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Game Background
                Rectangle()
                    .fill(.black)
                    .ignoresSafeArea()
                
                // Game Elements
                BallView(position: gameEngine.ballPosition)
                
                // Player Paddle
                PaddleView(
                    position: CGPoint(
                        x: gameEngine.paddleWidth / 2,
                        y: gameEngine.playerPaddleY + gameEngine.paddleHeight / 2
                    ),
                    width: gameEngine.paddleWidth,
                    height: gameEngine.paddleHeight
                )
                
                // Computer Paddle
                PaddleView(
                    position: CGPoint(
                        x: geometry.size.width - gameEngine.paddleWidth / 2,
                        y: gameEngine.computerPaddleY + gameEngine.paddleHeight / 2
                    ),
                    width: gameEngine.paddleWidth,
                    height: gameEngine.paddleHeight
                )
                
                // Score Display
                ScoreView(
                    playerScore: gameEngine.playerScore,
                    computerScore: gameEngine.computerScore
                )
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        gameEngine.playerPaddleY = min(
                            max(value.location.y - gameEngine.paddleHeight / 2, 0),
                            geometry.size.height - gameEngine.paddleHeight
                        )
                    }
            )
            .onAppear {
                gameEngine.setScreenSize(geometry.size)
                gameEngine.startGameLoop() // Ensure game loop starts when the view appears
            }
        }
    }
}

#Preview {
    ContentView()
}
