import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("followSystem") private var followSystem = true
    
    var body: some View {
        Form {
            Section(header: Text(NSLocalizedString("settings_title", comment: "Settings section title"))) {
                Toggle(isOn: $isDarkMode) {
                    Text(NSLocalizedString("settings_dark_mode", comment: "Dark Mode"))
                }
                if isDarkMode {
                    HStack {
                        Spacer().frame(width: 24)
                        Toggle(isOn: $followSystem) {
                            Text(NSLocalizedString("settings_follow_system", comment: "Follow System"))
                        }
                    }
                }
            }
        }
        .navigationTitle(NSLocalizedString("settings_title", comment: "Settings nav title"))
        .background(Color(.systemBackground))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
} 