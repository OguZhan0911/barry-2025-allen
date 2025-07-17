import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("followSystem") private var followSystem = true
    
    var body: some View {
        Form {
            Section(header: Text("Settings")) {
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                if isDarkMode {
                    HStack {
                        Spacer().frame(width: 24)
                        Toggle(isOn: $followSystem) {
                            Text("Follow System")
                        }
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .background(Color(.systemBackground))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
} 