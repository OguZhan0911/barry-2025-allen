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
            Text("Help U Rating")
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                Button(action: { isRegister = false }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(isRegister ? .gray : .blue)
                }
                Button(action: { isRegister = true }) {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(isRegister ? .blue : .gray)
                }
            }
            .padding(.bottom, 8)
            TextField("Enter your email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: 320)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: 320)
            if isRegister {
                SecureField("Confirm password", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .frame(maxWidth: 320)
            }
            Button(action: {
                userInfo.login()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(isRegister ? "Register" : "Login")
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
                .overlay(Text("[Image]").foregroundColor(.gray))
            Spacer()
        }
        .padding()
    }
}

private func makeAgreementText() -> AttributedString {
    var str = AttributedString("Upon login you agree the User's agreement and Privacy policy.")
    if let range = str.range(of: "User's agreement") {
        str[range].foregroundColor = .blue
        str[range].underlineStyle = .single
        str[range].link = URL(string: "http://www.barry-allen.com/agreement")!
    }
    if let range = str.range(of: "Privacy policy") {
        str[range].foregroundColor = .blue
        str[range].underlineStyle = .single
        str[range].link = URL(string: "http://www.barry-allen.com/pp")!
    }
    return str
}

#Preview {
    LoginView()
} 
