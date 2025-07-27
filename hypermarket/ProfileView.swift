import SwiftUI

struct ProfileView: View {
    @State private var showAboutWeb = false
    @State private var showLogin = false
    @State private var isLoggedIn = false // 简单登录状态
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 顶部栏，含设置按钮
                HStack {
                    Text("Personal")
                        .font(.headline)
                        .foregroundColor(Color.primary)
                    Spacer()
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color.primary)
                            .imageScale(.large)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                // 用户信息
                VStack(spacing: 8) {
                    Button(action: {
                        if !isLoggedIn {
                            showLogin = true
                        }
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                    Text(isLoggedIn ? "Guest User" : "Not Logged In")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Welcome to HyperMarket!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical)
                // 其他信息
                Form {
                    Section(header: Text("Others")) {
                        NavigationLink(destination: Text("Info")) {
                            Label("Info", systemImage: "bell")
                        }
                        NavigationLink(destination: Text("Feedback")) {
                            Label("Feedback", systemImage: "text.bubble")
                        }
                        Button(action: { showAboutWeb = true }) {
                            Label("About us", systemImage: "info.circle")
                        }
                        .sheet(isPresented: $showAboutWeb) {
                            SafariView(url: URL(string: "http://www.barry-allen.com/")!)
                        }
                    }
                }
                .padding(.top, -16)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showLogin) {
                LoginView()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 
