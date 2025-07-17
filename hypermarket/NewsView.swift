import SwiftUI

struct NewsItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let category: String
    let time: String
}

struct NewsView: View {
    let topImage = "photo" // FIXME: Replace with actual image
    let topTitle = "2024 Global Technology Innovation Summit is about to open"
    let news: [NewsItem] = [
        NewsItem(imageName: "photo", title: "AI breakthrough: self-learning system achieves major progress in medical diagnosis", category: "Tech Daily", time: "2 hours ago"),
        NewsItem(imageName: "photo", title: "New energy vehicle charging coverage exceeds 85%", category: "Auto Weekly", time: "4 hours ago"),
        NewsItem(imageName: "photo", title: "New crypto regulation platform launched, global financial market welcomes big change", category: "Finance News", time: "6 hours ago"),
        NewsItem(imageName: "photo", title: "Mars probe lands successfully! First Mars soil samples return to Earth", category: "Aerospace", time: "8 hours ago"),
        NewsItem(imageName: "photo", title: "Biotech breakthrough: new gene therapy targets multiple genetic diseases", category: "Medical Journal", time: "12 hours ago")
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Top image and title
                    ZStack(alignment: .bottomLeading) {
                        Image(topImage)
                            .resizable()
                            .aspectRatio(16/9, contentMode: .fill)
                            .frame(height: 160)
                            .clipped()
                        Text(topTitle)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.4))
                    }
                    .cornerRadius(10)
                    .padding(.horizontal)
                    // News list
                    ForEach(news) { item in
                        HStack(alignment: .top, spacing: 12) {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 80, height: 60)
                                .cornerRadius(8)
                                .background(Color.gray.opacity(0.2)) // FIXME: Replace with actual image
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.title)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                HStack(spacing: 8) {
                                    Text(item.category)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(item.time)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("News")
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
} 