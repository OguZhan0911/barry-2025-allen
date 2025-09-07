import SwiftUI

struct CompoundInterestCalculatorView: View {
    @State private var principal: String = ""
    @State private var rate: String = ""
    @State private var years: String = ""
    @State private var result: Double?
    
    var body: some View {
        Form {
            Section(header: Text(NSLocalizedString("ci_input", comment: "Input section"))) {
                TextField(NSLocalizedString("ci_principal", comment: "Principal"), text: $principal)
                    .keyboardType(.decimalPad)
                TextField(NSLocalizedString("ci_rate", comment: "Annual rate"), text: $rate)
                    .keyboardType(.decimalPad)
                TextField(NSLocalizedString("ci_years", comment: "Years"), text: $years)
                    .keyboardType(.numberPad)
            }
            Button(NSLocalizedString("ci_calculate", comment: "Calculate")) {
                calculateCompoundInterest()
            }
            Section(header: Text(NSLocalizedString("ci_result", comment: "Result section"))) {
                if let result = result {
                    Text(String(format: NSLocalizedString("ci_future_value", comment: "Future value format"), result))
                        .font(.headline)
                } else {
                    Text(NSLocalizedString("ci_enter_values", comment: "Enter values hint"))
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle(NSLocalizedString("ci_nav_title", comment: "CI nav title"))
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