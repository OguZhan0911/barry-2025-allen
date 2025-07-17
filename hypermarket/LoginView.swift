import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var isRegister = false
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
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
                isLoggedIn = true
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(isRegister ? "Register" : "Login")
                    .frame(maxWidth: 320)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Text("Upon login you agree the User's agreement and Privacy policy")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 320)
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