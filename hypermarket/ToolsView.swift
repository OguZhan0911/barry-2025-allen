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
                Section(header: Text(NSLocalizedString("tools_section_articles", comment: "Articles section"))) {
                    ForEach(articles, id: \.self) { article in
                        NavigationLink(destination: Text(article)) {
                            Text(article)
                        }
                    }
                }
                Section(header: Text(NSLocalizedString("tools_section_tools", comment: "Tools section"))) {
                    NavigationLink(destination: CompoundInterestCalculatorView()) {
                        Text(NSLocalizedString("tools_compound_interest", comment: "Compound interest tool"))
                    }
                    Text(NSLocalizedString("tools_currency_converter", comment: "Currency converter placeholder"))
                    Text(NSLocalizedString("tools_loan_calculator", comment: "Loan calculator placeholder"))
                }
            }
            .navigationTitle(NSLocalizedString("tab_tools", comment: "Tools nav title"))
        }
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
} 