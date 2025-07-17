import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User")) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Guest User")
                                .font(.headline)
                            Text("Welcome to HyperMarket!")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Section(header: Text("Settings")) {
                    Toggle(isOn: .constant(false)) {
                        Text("Dark Mode (Coming Soon)")
                    }
                    NavigationLink(destination: Text("About HyperMarket")) {
                        Text("About")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 