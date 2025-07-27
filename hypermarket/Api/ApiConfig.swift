import Foundation

struct ApiConfig {
    static let host = "http://api.barry-allen.com"
}

enum ApiPath: String {
    case getFinancialInstitutionRatings = "/financialInstitutionRatings/getFinancialInstitutionRatingsPublic"
    case getFinancialKnowledge = "/financialKnowledge/getFinancialKnowledgePublic"
} 
