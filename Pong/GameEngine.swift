
import SwiftUI
import Combine

final class GameEngine: ObservableObject {
    // Game State
    @Published var ballPosition = CGPoint(x: 100, y: 100)
    @Published var playerPaddleY: CGFloat = 0
    @Published var computerPaddleY: CGFloat = 0
    @Published var playerScore = 0
    @Published var computerScore = 0
    
    // Configuration
    let paddleWidth: CGFloat = 20
    let paddleHeight: CGFloat = 100
    @AppStorage("ballSpeed") private var storedBallSpeed: Double = 5.0
    @AppStorage("paddleColor") private var paddleColorString: String = "#FFFFFF" // Hex string
    @AppStorage("soundEnabled") private var soundEnabled: Bool = true
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    
    var ballSpeed = CGSize(width: 5, height: 5)
    
    private var timer: AnyCancellable?
    private var screenSize: CGSize = .zero
    
    // Convert stored hex string to Color
    private var paddleColor: Color {
        Color(hex: paddleColorString)
    }
    
    init() {
        updateBallSpeed() // Set ball speed based on settings
    }
    
    // Change the access level here
    func startGameLoop() {  // This used to be private
        timer = Timer.publish(every: 0.02, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateGame()
            }
    }
    
    func setScreenSize(_ size: CGSize) {
        screenSize = size
        resetBall()
    }
    
    private func updateGame() {
        // Ball movement
        ballPosition.x += ballSpeed.width
        ballPosition.y += ballSpeed.height
        
        // Wall collisions
        if ballPosition.y <= 0 || ballPosition.y >= screenSize.height {
            ballSpeed.height *= -1
            playSound() // Play sound on wall collision
        }
        
        updateComputerPaddle()
        checkPaddleCollisions()
        checkScoring()
    }
    
    private func updateComputerPaddle() {
        let paddleCenter = computerPaddleY + paddleHeight / 2
        if paddleCenter < ballPosition.y - 35 {
            computerPaddleY += 5
        } else if paddleCenter > ballPosition.y + 35 {
            computerPaddleY -= 5
        }
    }
    
    private func checkPaddleCollisions() {
        let ballFrame = CGRect(
            x: ballPosition.x - 10,
            y: ballPosition.y - 10,
            width: 20,
            height: 20
        )
        
        let playerPaddleFrame = CGRect(
            x: 0,
            y: playerPaddleY,
            width: paddleWidth,
            height: paddleHeight
        )
        
        let computerPaddleFrame = CGRect(
            x: screenSize.width - paddleWidth,
            y: computerPaddleY,
            width: paddleWidth,
            height: paddleHeight
        )
        
        if ballFrame.intersects(playerPaddleFrame) || ballFrame.intersects(computerPaddleFrame) {
            ballSpeed.width *= -1
            playSound() // Play sound on paddle collision
            triggerVibration() // Trigger vibration on paddle collision
        }
    }
    
    private func checkScoring() {
        if ballPosition.x < 0 {
            computerScore += 1
            resetBall()
            playSound() // Play sound when the computer scores
        } else if ballPosition.x > screenSize.width {
            playerScore += 1
            resetBall()
            playSound() // Play sound when the player scores
        }
    }
    
    private func resetBall() {
        ballPosition = CGPoint(
            x: screenSize.width / 2,
            y: screenSize.height / 2
        )
        ballSpeed = CGSize(
            width: [-storedBallSpeed, storedBallSpeed].randomElement()!,
            height: [-storedBallSpeed, storedBallSpeed].randomElement()!
        )
    }
    
    private func updateBallSpeed() {
        // Update the ball speed based on the stored value
        ballSpeed = CGSize(width: storedBallSpeed, height: storedBallSpeed)
    }
    
    private func playSound() {
        if soundEnabled {
            // Play the sound here, e.g., ball-paddle hit or score
        }
    }
    
    private func triggerVibration() {
        if vibrationEnabled {
            // Trigger vibration here, e.g., when ball hits the paddle
        }
    }
}


extension Color {
    // Convert hex string to Color
    init(hexString: String) {
        let hex = hexString.replacingOccurrences(of: "#", with: "")
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let red = CGFloat((int >> 16) & 0xFF) / 255
        let green = CGFloat((int >> 8) & 0xFF) / 255
        let blue = CGFloat(int & 0xFF) / 255
        self.init(red: red, green: green, blue: blue)
    }
}
