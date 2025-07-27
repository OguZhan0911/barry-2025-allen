import Foundation
import Combine

class UserInfoManager: ObservableObject {
    static let shared = UserInfoManager()
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    private init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    func login() {
        isLoggedIn = true
    }
    func logout() {
        isLoggedIn = false
    }
} 