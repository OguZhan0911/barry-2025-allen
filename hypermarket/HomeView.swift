import SwiftUI

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

struct HomeView: View {
    // Sample data
    let bankRatings: [BankRating] = [
        BankRating(name: "China Merchants Bank", rating: 4.5),
        BankRating(name: "China CITIC Bank", rating: 4.5),
        BankRating(name: "China CITIC Bank", rating: 4.0)
    ]
    let knowledgeList: [KnowledgeItem] = [
        KnowledgeItem(title: "How to improve loan approval rate?", desc: "Detailed explanation of key factors affecting loan approval, including credit history, income proof, years of employment, etc., to help you better prepare your loan application materials.", reads: 2456, likes: 328),
        KnowledgeItem(title: "2024 Latest Loan Policy Interpretation", desc: "Interpret the latest changes in loan policies, including interest rate adjustments, eligibility requirements, quota restrictions, and other important information to help you keep up with market trends.", reads: 1892, likes: 256)
    ]
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top Logo
                HStack {
                    // FIXME: Replace with actual logo image
                    Text("logo")
                        .font(.custom("Snell Roundhand", size: 28))
                        .foregroundColor(.blue)
                    Spacer()
                }
                .padding([.top, .horizontal])
                .padding(.bottom, 8)
                
                Divider()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Banner area
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.8), .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 140)
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Finance")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text("Your Robust Rating Support. Find the most fit bank you need.\nSign up for better benefits and insights.")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.9))
                                    Button(action: {/* FIXME: banner button action */}) {
                                        Text("Create very loan")
                                            .font(.caption)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 6)
                                            .background(Color.white)
                                            .foregroundColor(.blue)
                                            .cornerRadius(12)
                                    }
                                }
                                Spacer()
                                // FIXME: Replace with actual banner image
                                Image(systemName: "building.columns.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .padding()
                        }
                        // Feature entries
                        HStack {
                            Spacer()
                            HStack(spacing: 24) {
                                VStack {
                                    // FIXME: Replace with actual icon
                                    Image(systemName: "chart.pie.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.orange)
                                    Text("Rating")
                                        .font(.subheadline)
                                }
                                VStack {
                                    // FIXME: Replace with actual icon
                                    Image(systemName: "percent")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.purple)
                                    Text("Guide")
                                        .font(.subheadline)
                                }
                                VStack {
                                    // FIXME: Replace with actual icon
                                    Image(systemName: "checkmark.seal.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.blue)
                                    Text("Bouns")
                                        .font(.subheadline)
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        // Financial institution ratings
                        HStack {
                            Text("Financial institution ratings")
                                .font(.headline)
                            Spacer()
                            Button(action: {/* FIXME: more ratings */}) {
                                Text("more")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(bankRatings, id: \.self) { bank in
                                    VStack(alignment: .center, spacing: 8) {
                                        Image(systemName: "creditcard")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 48, height: 48)
                                            .foregroundColor(.blue)
                                            .padding(.top, 16)
                                        Text(bank.name)
                                            .font(.subheadline)
                                            .multilineTextAlignment(.center)
                                        HStack(spacing: 2) {
                                            ForEach(0..<5) { i in
                                                Image(systemName: i < Int(bank.rating) ? "star.fill" : "star")
                                                    .resizable()
                                                    .frame(width: 12, height: 12)
                                                    .foregroundColor(.yellow)
                                            }
                                            Text(String(format: "%.1f score", bank.rating))
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer(minLength: 8)
                                    }
                                    .frame(width: 140, height: 150)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.blue.opacity(0.1))
                                    )
                                }
                            }
                        }
                        // Financial Knowledge
                        HStack {
                            Text("Financial Knowledge")
                                .font(.headline)
                            Spacer()
                            Button(action: {/* FIXME: more knowledge */}) {
                                Text("more")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        VStack(spacing: 12) {
                            ForEach(knowledgeList, id: \.self) { item in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(item.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Text(item.desc)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    HStack(spacing: 16) {
                                        Text("Read \(item.reads)")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                        Text("Likes \(item.likes)")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                        Spacer(minLength: 24)
                    }
                    .padding()
                }
                // Bottom TabBar
                Divider()
                HStack {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Index").font(.caption)
                    }.foregroundColor(.blue)
                    Spacer()
                    VStack {
                        Image(systemName: "newspaper")
                        Text("News").font(.caption)
                    }.foregroundColor(.gray)
                    Spacer()
                    VStack {
                        Image(systemName: "doc.text.magnifyingglass")
                        Text("Rating").font(.caption)
                    }.foregroundColor(.gray)
                    Spacer()
                    VStack {
                        Image(systemName: "person")
                        Text("Personal").font(.caption)
                    }.foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(Color.white)
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 
