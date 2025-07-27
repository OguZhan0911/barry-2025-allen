import SwiftUI

struct BankListView: View {
    let banks: [FinancialInstitutionRating]
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                Text("Financial institution ratings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top)
                ForEach(banks, id: \.id) { bank in
                    BankCardView(bank: bank)
                        .frame(maxWidth: UIScreen.main.bounds.width - 20 * 2)
                        .padding(.horizontal)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
    }
}

#if DEBUG
#Preview {
    let mockBanks = [
        FinancialInstitutionRating(
            id: 1,
            institutionImage: "https://www.citi.com/CBOL/IA/Angular/assets/citiredesign.svg",
            institutionName: "Citibank",
            institutionDescription: "A major global banking group offering corporate banking, personal banking, and investment services.",
            rating: 4.5,
            tags: "服务态度好, 网银体验佳, 网点覆盖广"
        ),
        FinancialInstitutionRating(
            id: 2,
            institutionImage: "https://www.hsbc.com.hk/content/dam/hsbc/hk/images/hongkong-hsbc-logo-en.svg",
            institutionName: "HSBC",
            institutionDescription: "A well-established British bank focusing on Asia, global trade finance, and wealth management.",
            rating: 4.4,
            tags: "线上办理快, 产品种类多, 手续费低"
        )
    ]
    return BankListView(banks: mockBanks)
}
#endif

struct BankCardView: View {
    let bank: FinancialInstitutionRating
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 16) {
                Group {
                    if bank.institutionImage.hasSuffix(".svg") {
                        if let url = URL(string: bank.institutionImage) {
                            SVGImageView(url: url)
                                .aspectRatio(1, contentMode: .fit)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                        }
                    } else {
                        AsyncImage(url: URL(string: bank.institutionImage)) { image in
                            image.resizable().aspectRatio(1, contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .frame(width: 56, height: 56)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray4), lineWidth: 1))
                VStack(alignment: .leading, spacing: 4) {
                    Text(bank.institutionName)
                        .font(.headline)
                    HStack(spacing: 4) {
                        ForEach(0..<5) { i in
                            Image(systemName: i < Int(bank.rating) ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .foregroundColor(.yellow)
                        }
                        Text(String(format: "%.1f", bank.rating))
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
            }
            Text(bank.institutionDescription)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            // 标签分割并缩写
            let tags = bank.tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    let shortTag = tag.count > 10 ? String(tag.prefix(10)) + "…" : tag
                    Text(shortTag)
                        .font(.caption)
                        .lineLimit(1)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color(.systemGray3).opacity(0.13), radius: 4, x: 0, y: 2)
    }
} 
