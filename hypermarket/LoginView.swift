import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isRegister = false
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAgreement = false
    @State private var showPrivacy = false
    @State private var isAgreed = true
    @ObservedObject private var userInfo = UserInfoManager.shared
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("logo")
                .font(.custom("Snell Roundhand", size: 32))
                .foregroundColor(.blue)
            Text(NSLocalizedString("login_brand_tagline", comment: "Brand tagline on login"))
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Button(action: { isRegister = false }) {
                    Text(NSLocalizedString("login_login", comment: "Login switch"))
                        .font(.headline)
                        .foregroundColor(isRegister ? .gray : .blue)
                }
                Button(action: { isRegister = true }) {
                    Text(NSLocalizedString("login_register", comment: "Register switch"))
                        .font(.headline)
                        .foregroundColor(isRegister ? .blue : .gray)
                }
            }
            .padding(.bottom, 8)
            TextField(NSLocalizedString("login_placeholder_email", comment: "Email placeholder"), text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: 320)
            SecureField(NSLocalizedString("login_placeholder_password", comment: "Password placeholder"), text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: 320)
            if isRegister {
                SecureField(NSLocalizedString("login_placeholder_confirm", comment: "Confirm password placeholder"), text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(maxWidth: 320)
            }
            Button(action: {
                userInfo.login()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(isRegister ? NSLocalizedString("login_button_register", comment: "Register button") : NSLocalizedString("login_button_login", comment: "Login button"))
                    .frame(maxWidth: 320)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            // 富文本提示
            HStack(alignment: .top, spacing: 8) {
                Button(action: { isAgreed.toggle() }) {
                    Image(systemName: isAgreed ? "checkmark.square.fill" : "square")
                        .foregroundColor(isAgreed ? .blue : .gray)
                }
                .buttonStyle(PlainButtonStyle())
                Text(makeAgreementText())
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(maxWidth: 320, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .onOpenURL { url in
                        if url.absoluteString.contains("agreement") {
                            showAgreement = true
                        } else if url.absoluteString.contains("pp") {
                            showPrivacy = true
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showPrivacy = true
                    }
            }
                .sheet(isPresented: $showAgreement) {
                    SafariView(url: URL(string: "http://www.barry-allen.com/agreement")!)
                }
                .sheet(isPresented: $showPrivacy) {
                    SafariView(url: URL(string: "http://www.barry-allen.com/pp")!)
                }
            Spacer()
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 120)
                .cornerRadius(8)
                .frame(maxWidth: 340)
                .overlay(Text(NSLocalizedString("login_image_placeholder", comment: "Image placeholder text")).foregroundColor(.gray))
            Spacer()
        }
        .padding()
    }
}

private func makeAgreementText() -> AttributedString {
    var str = AttributedString(NSLocalizedString("login_agreement_full", comment: "Full agreement text"))
    if let range = str.range(of: NSLocalizedString("login_agreement_user", comment: "User agreement anchor")) {
        str[range].foregroundColor = .blue
        str[range].underlineStyle = .single
        str[range].link = URL(string: "http://www.barry-allen.com/agreement")!
    }
    if let range = str.range(of: NSLocalizedString("login_agreement_privacy", comment: "Privacy policy anchor")) {
        str[range].foregroundColor = .blue
        str[range].underlineStyle = .single
        str[range].link = URL(string: "http://www.barry-allen.com/pp")!
    }
    return str
}

#Preview {
    LoginView()
} 
