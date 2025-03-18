
import SwiftUI

struct SettingsView: View {
    @AppStorage("difficulty") private var difficulty: String = "Medium"
    @AppStorage("ballSpeed") private var ballSpeed: Double = 5.0
    @AppStorage("paddleColor") private var paddleColorString: String = "#FFFFFF" // Store color as hex string
    @AppStorage("soundEnabled") private var soundEnabled: Bool = true
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    
    @Environment(\.presentationMode) var presentationMode // To go back to MenuView

    // Convert stored hex string to Color
    private var paddleColor: Color {
        Color(hex: paddleColorString)
    }

    var body: some View {
        NavigationView {
            Form {
                // Difficulty Level Picker
                Section(header: Text("Difficulty Level")) {
                    Picker("Select Difficulty", selection: $difficulty) {
                        Text("Easy").tag("Easy")
                        Text("Medium").tag("Medium")
                        Text("Hard").tag("Hard")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Ball Speed Slider
                Section(header: Text("Ball Speed")) {
                    Slider(value: $ballSpeed, in: 3...10, step: 1) {
                        Text("Ball Speed")
                    }
                    Text("Speed: \(Int(ballSpeed))")
                }

                // Paddle Color Picker
                Section(header: Text("Paddle Color")) {
                    ColorPicker("Choose Paddle Color", selection: Binding(
                        get: { self.paddleColor },
                        set: { newColor in
                            // Convert selected color to hex string and store it
                            self.paddleColorString = newColor.toHex() ?? "#FFFFFF"
                        }
                    ))
                }

                // Sound and Vibration Toggles
                Section {
                    Toggle("Enable Sound", isOn: $soundEnabled)
                    Toggle("Enable Vibration", isOn: $vibrationEnabled)
                }

                // Save & Close Button
                Button("Save & Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .navigationTitle("Settings")
        }
    }
}

// Extension for Color to handle Hex conversion
extension Color {
    // Convert hex string to Color
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let red = CGFloat((int >> 16) & 0xFF) / 255
        let green = CGFloat((int >> 8) & 0xFF) / 255
        let blue = CGFloat(int & 0xFF) / 255
        self.init(red: red, green: green, blue: blue)
    }

    // Convert Color to hex string
    func toHex() -> String? {
        let uiColor = UIColor(self)
        guard let components = uiColor.cgColor.components else { return nil }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
    }
}

// Preview for the Settings View
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
