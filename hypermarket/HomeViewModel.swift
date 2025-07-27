import Foundation
import SwiftUI
import Moya

struct FinancialInstitutionRating: Codable, Hashable {
    let id: Int
    let institutionImage: String
    let institutionName: String
    let institutionDescription: String
    let rating: Double
    let tags: String
}

struct InstitutionData: Decodable {
    let list: [FinancialInstitutionRating]
}

struct BankRating: Hashable {
    let name: String
    let rating: Double
}

struct KnowledgeItem: Codable,Hashable {
    let title: String
    let desc: String
    let reads: Int
    let likes: Int
}

struct KnowledgeData: Decodable {
    let list: [KnowledgeItem]
}

class HomeViewModel: ObservableObject {
    @Published var bankRatings: [BankRating] = []
    @Published var knowledgeList: [KnowledgeItem] = []
    @Published var institutionList: [FinancialInstitutionRating] = []
    private let provider = MoyaProvider<ApiService>()
    
    init() {
        fetchBankRatings()
        fetchKnowledgeList()
    }
    
    func fetchBankRatings() {
        provider.request(.getFinancialInstitutionRatings) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try response.mapDecodable(ApiResponse<InstitutionData>.self)
                    DispatchQueue.main.async {
                        self?.institutionList = decoded.data.list
                        self?.bankRatings = decoded.data.list.map { BankRating(name: $0.institutionName, rating: $0.rating) }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.bankRatings = [
                            BankRating(name: "China Merchants Bank", rating: 4.5),
                            BankRating(name: "China CITIC Bank", rating: 4.5),
                            BankRating(name: "China CITIC Bank", rating: 4.0)
                        ]
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.bankRatings = [
                        BankRating(name: "China Merchants Bank", rating: 4.5),
                        BankRating(name: "China CITIC Bank", rating: 4.5),
                        BankRating(name: "China CITIC Bank", rating: 4.0)
                    ]
                }
            }
        }
    }
    
    func fetchKnowledgeList() {
        let mockList = [
            KnowledgeItem(title: "How to improve loan approval rate?", desc: "Detailed explanation of key factors affecting loan approval, including credit history, income proof, years of employment, etc., to help you better prepare your loan application materials.", reads: 2456, likes: 328),
            KnowledgeItem(title: "2024 Latest Loan Policy Interpretation", desc: "Interpret the latest changes in loan policies, including interest rate adjustments, eligibility requirements, quota restrictions, and other important information to help you keep up with market trends.", reads: 1892, likes: 256)
        ]
        provider.request(.getFinancialKnowledge) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try response.mapDecodable(ApiResponse<KnowledgeData>.self)
                    DispatchQueue.main.async {
                        self?.knowledgeList = decoded.data.list.isEmpty ? mockList : decoded.data.list
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.knowledgeList = mockList
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.knowledgeList = mockList
                }
            }
        }
    }
} 
