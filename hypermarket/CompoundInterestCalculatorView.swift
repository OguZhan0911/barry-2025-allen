import SwiftUI

struct CompoundInterestCalculatorView: View {
    @State private var principal: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var result: Double?
    
    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Principal Amount", text: $principal)
                    .keyboardType(.decimalPad)
                TextField("Annual Interest Rate (%)", text: $rate)
                    .keyboardType(.decimalPad)
                TextField("Years", text: $years)
                    .keyboardType(.numberPad)
            }
            Button("Calculate") {
                calculateCompoundInterest()
            }
            Section(header: Text("Result")) {
                if let result = result {
                    Text("Future Value: $\(String(format: "%.2f", result))")
                        .font(.headline)
                } else {
                    Text("Enter values and tap Calculate.")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Compound Interest")
    }
    
    func calculateCompoundInterest() {
        guard let p = Double(principal), let r = Double(rate), let t = Double(years) else {
            result = nil
            return
        }
        let futureValue = p * pow(1 + r / 100, t)
        result = futureValue
    }
}

struct CompoundInterestCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundInterestCalculatorView()
    }
} 