import SwiftUI

struct ToolsView: View {
    let articles = [
        "The Basics of Stock Markets",
        "What is Cryptocurrency?",
        "Understanding Mutual Funds",
        "Retirement Planning 101",
        "Credit Scores Explained"
    ]
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Articles")) {
                    ForEach(articles, id: \.self) { article in
                        NavigationLink(destination: Text(article)) {
                            Text(article)
                        }
                    }
                }
                Section(header: Text("Tools")) {
                    NavigationLink(destination: CompoundInterestCalculatorView()) {
                        Text("Compound Interest Calculator")
                    }
                    Text("Currency Converter (Coming Soon)")
                    Text("Loan Calculator (Coming Soon)")
                }
            }
            .navigationTitle("Tools")
        }
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
} 