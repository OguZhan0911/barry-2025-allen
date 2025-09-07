import SwiftUI

struct BankListView: View {
    let banks: [FinancialInstitutionRating]
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                Text(NSLocalizedString("bank_list_title", comment: "Title for bank list screen"))
                    .font(AppFonts.largeTitle)
                    .foregroundColor(AppColors.textPrimary)
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
        .background(AppColors.background.ignoresSafeArea())
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
                .overlay(Circle().stroke(AppColors.tagText.opacity(0.2), lineWidth: 1))
                VStack(alignment: .leading, spacing: 4) {
                    Text(bank.institutionName)
                        .font(AppFonts.headline)
                        .foregroundColor(AppColors.textPrimary)
                    HStack(spacing: 4) {
                        ForEach(0..<5) { i in
                            Image(systemName: i < Int(bank.rating) ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .foregroundColor(AppColors.star)
                        }
                        Text(String(format: "%.1f", bank.rating))
                            .font(AppFonts.subheadline)
                            .foregroundColor(AppColors.primary)
                    }
                }
                Spacer()
            }
            Text(bank.institutionDescription)
                .font(AppFonts.subheadline)
                .foregroundColor(AppColors.textSecondary)
                .lineLimit(2)
            // 标签分割并缩写
            let tags = bank.tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    let shortTag = tag.count > 6 ? String(tag.prefix(6)) + "…" : tag
                    Text(shortTag)
                        .font(AppFonts.caption)
                        .foregroundColor(AppColors.tagText)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppColors.tagBackground)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.card)
        .cornerRadius(16)
        .shadow(color: AppColors.cardShadow, radius: 4, x: 0, y: 2)
    }
} 
