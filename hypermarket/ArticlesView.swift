import SwiftUI

struct ArticlesView: View {
    let articles = [
        "The Basics of Stock Markets",
        "What is Cryptocurrency?",
        "Understanding Mutual Funds",
        "Retirement Planning 101",
        "Credit Scores Explained"
    ]
    var body: some View {
        NavigationView {
            List(articles, id: \.self) { article in
                NavigationLink(destination: Text(article)) {
                    Text(article)
                }
            }
            .navigationTitle("Articles")
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
} 