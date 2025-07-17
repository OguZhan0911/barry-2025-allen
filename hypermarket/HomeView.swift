import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to HyperMarket!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Your daily source of financial wisdom.")
                    .font(.title3)
                    .foregroundColor(.secondary)
                Divider()
                Text("Recommended for you")
                    .font(.headline)
                VStack(alignment: .leading, spacing: 10) {
                    Text("• 5 Tips for Smart Investing")
                    Text("• Understanding Compound Interest")
                    Text("• How to Build a Budget")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 