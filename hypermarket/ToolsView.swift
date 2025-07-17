import SwiftUI

struct ToolsView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CompoundInterestCalculatorView()) {
                    Text("Compound Interest Calculator")
                }
                Text("Currency Converter (Coming Soon)")
                Text("Loan Calculator (Coming Soon)")
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