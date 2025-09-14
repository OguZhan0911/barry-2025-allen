import Foundation
import Combine
import Moya

class UserInfoManager: ObservableObject {
    static let shared = UserInfoManager()
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    private let provider = MoyaProvider<ApiService>()
    
    private init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        // 检查是否为本地测试账号
        if email == "ba@test.com" && password == "A12345678" {
            // 本地测试账号直接登录成功
            DispatchQueue.main.async {
                self.isLoggedIn = true
                completion(true, nil)
            }
            return
        }
        
        // 其他账号调用API接口
        provider.request(.login(email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try response.mapDecodable(ApiResponse<LoginResponse>.self)
                    DispatchQueue.main.async {
                        if decoded.code == 200 {
                            self?.isLoggedIn = true
                            completion(true, nil)
                        } else {
                            completion(false, decoded.msg)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false, NSLocalizedString("login_error_failed", comment: "Login failed error"))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let networkError = String(format: NSLocalizedString("login_error_network", comment: "Network error"), error.localizedDescription)
                    completion(false, networkError)
                }
            }
        }
    }
    
    func logout() {
        isLoggedIn = false
    }
}

struct LoginResponse: Codable {
    let token: String?
    let userInfo: UserInfo?
}

struct UserInfo: Codable {
    let id: String?
    let email: String?
    let name: String?
} 