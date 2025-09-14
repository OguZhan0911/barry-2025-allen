import Foundation
import Moya

enum ApiService {
    case getFinancialInstitutionRatings
    case getFinancialKnowledge
    case login(email: String, password: String)
    // 可继续添加 case
}

extension ApiService: TargetType {
    var baseURL: URL {
        return URL(string: ApiConfig.host)!
    }
    var path: String {
        switch self {
        case .getFinancialInstitutionRatings:
            return ApiPath.getFinancialInstitutionRatings.rawValue
        case .getFinancialKnowledge:
            return ApiPath.getFinancialKnowledge.rawValue
        case .login:
            return ApiPath.login.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
        case .getFinancialInstitutionRatings, .getFinancialKnowledge, .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .getFinancialInstitutionRatings, .getFinancialKnowledge:
            return .requestPlain // 空body
        case .login(let email, let password):
            let parameters = ["email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    var headers: [String : String]? {
        ["accept": "application/json"]
    }
    var sampleData: Data { Data() }
}

extension Response {
    func mapDecodable<T: Decodable>(_ type: T.Type) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
} 