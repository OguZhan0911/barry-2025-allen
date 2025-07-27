import Foundation
import SwiftUI

struct FinancialInstitutionRating: Codable, Hashable {
    let id: Int
    let institutionImage: String
    let institutionName: String
    let institutionDescription: String
    let rating: Double
    let tags: String
}

struct FinancialInstitutionRatingResponse: Codable {
    struct Data: Codable {
        let list: [FinancialInstitutionRating]
    }
    let code: Int
    let data: Data
    let msg: String
}

struct BankRating: Hashable {
    let name: String
    let rating: Double
}

struct KnowledgeItem: Hashable {
    let title: String
    let desc: String
    let reads: Int
    let likes: Int
}

class HomeViewModel: ObservableObject {
    @Published var bankRatings: [BankRating] = []
    @Published var knowledgeList: [KnowledgeItem] = []
    @Published var institutionList: [FinancialInstitutionRating] = []
    
    init() {
        fetchBankRatings()
        fetchKnowledgeList()
    }
    
    func fetchBankRatings() {
        guard let url = URL(string: "http://api.barry-allen.com/financialInstitutionRatings/getFinancialInstitutionRatingsPublic") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.bankRatings = [
                        BankRating(name: "China Merchants Bank", rating: 4.5),
                        BankRating(name: "China CITIC Bank", rating: 4.5),
                        BankRating(name: "China CITIC Bank", rating: 4.0)
                    ]
                }
                return
            }
            do {
                let decoded = try JSONDecoder().decode(FinancialInstitutionRatingResponse.self, from: data)
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
        }
        task.resume()
    }
    
    func fetchKnowledgeList() {
        // TODO: Replace with real network request
        self.knowledgeList = [
            KnowledgeItem(title: "How to improve loan approval rate?", desc: "Detailed explanation of key factors affecting loan approval, including credit history, income proof, years of employment, etc., to help you better prepare your loan application materials.", reads: 2456, likes: 328),
            KnowledgeItem(title: "2024 Latest Loan Policy Interpretation", desc: "Interpret the latest changes in loan policies, including interest rate adjustments, eligibility requirements, quota restrictions, and other important information to help you keep up with market trends.", reads: 1892, likes: 256)
        ]
    }
} 