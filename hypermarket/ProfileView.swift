import SwiftUI

struct ProfileView: View {
    @State private var showAboutWeb = false
    @State private var showLogin = false
    @ObservedObject private var userInfo = UserInfoManager.shared
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 顶部栏，含设置按钮
                HStack {
                    Text(NSLocalizedString("profile_title", comment: "Profile title"))
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
                        if !userInfo.isLoggedIn {
                            showLogin = true
                        }
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                    Text(userInfo.isLoggedIn ? NSLocalizedString("profile_guest_user", comment: "Guest user title") : NSLocalizedString("profile_not_logged_in", comment: "Not logged in status"))
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(NSLocalizedString("profile_welcome", comment: "Welcome subtitle"))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if userInfo.isLoggedIn {
                        Button(action: {
                            userInfo.logout()
                        }) {
                            Text(NSLocalizedString("profile_logout", comment: "Logout button"))
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(8)
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.vertical)
                // 其他信息
                Form {
                    Section(header: Text(NSLocalizedString("profile_section_others", comment: "Others section title"))) {
                        NavigationLink(destination: Text(NSLocalizedString("profile_info", comment: "Info title"))) {
                            Label(NSLocalizedString("profile_info", comment: "Info label"), systemImage: "bell")
                        }
                        NavigationLink(destination: FeedbackView()) {
                            Label(NSLocalizedString("profile_feedback", comment: "Feedback label"), systemImage: "text.bubble")
                        }
                        Button(action: { showAboutWeb = true }) {
                            Label(NSLocalizedString("profile_about_us", comment: "About us label"), systemImage: "info.circle")
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
