
import SwiftUI

struct MenuView: View {
    @State private var isGameActive = false
    @State private var showSettings = false

    var body: some View {
        if isGameActive {
            ContentView()
        } else {
            VStack(spacing: 20) {
                Text("Pong Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Button("Start Game") {
                    isGameActive = true
                }
                .buttonStyle(GameButtonStyle(color: .green))

                Button("Settings") {
                    showSettings = true
                }
                .buttonStyle(GameButtonStyle(color: .blue))
                .sheet(isPresented: $showSettings) {
                    SettingsView() // Opens settings in a modal
                }

                Button("Quit") {
                    exit(0)
                }
                .buttonStyle(GameButtonStyle(color: .red))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
        }
    }
}

// Custom button style
struct GameButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 200)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

#Preview {
    MenuView()
}
