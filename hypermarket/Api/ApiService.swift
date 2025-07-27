import Foundation
import Moya

enum ApiService {
    case getFinancialInstitutionRatings
    case getFinancialKnowledge
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
        }
    }
    var method: Moya.Method {
        switch self {
        case .getFinancialInstitutionRatings, .getFinancialKnowledge:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .getFinancialInstitutionRatings, .getFinancialKnowledge:
            return .requestPlain // 空body
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