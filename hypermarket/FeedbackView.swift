import SwiftUI

struct FeedbackView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var feedbackText = ""
    @State private var isSubmitting = false
    @State private var showSuccessAlert = false
    
    private let maxCharacters = 200
    
    var body: some View {
        VStack(spacing: 0) {
            // 自定义导航栏
            HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    HStack(spacing: 4) {
//                        Image(systemName: "chevron.left")
//                            .font(.system(size: 16, weight: .medium))
//                        Text(NSLocalizedString("common_back", comment: "Back button"))
//                    }
//                    .foregroundColor(.blue)
//                }
//                
//                Spacer()
                
                Text(NSLocalizedString("feedback_title", comment: "Feedback title"))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // 占位符，保持标题居中
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                    Text(NSLocalizedString("common_back", comment: "Back button"))
                }
                .opacity(0)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .overlay(
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(Color(.separator)),
                alignment: .bottom
            )
            
            ScrollView {
                VStack(spacing: 20) {
                    // 描述
                    VStack(alignment: .leading, spacing: 8) {
                        Text(NSLocalizedString("feedback_description", comment: "Feedback description"))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                    // 文本输入区域
                    VStack(alignment: .leading, spacing: 8) {
                        Text(NSLocalizedString("feedback_input_label", comment: "Feedback input label"))
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemGray6))
                                .frame(height: 200)
                            
                            TextEditor(text: $feedbackText)
                                .padding(12)
                                .background(Color.clear)
                                .frame(height: 200)
                                .onChange(of: feedbackText) { newValue in
                                    if newValue.count > maxCharacters {
                                        feedbackText = String(newValue.prefix(maxCharacters))
                                    }
                                }
                            
                            if feedbackText.isEmpty {
                                Text(NSLocalizedString("feedback_placeholder", comment: "Feedback placeholder"))
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 20)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                        // 字符计数
                        HStack {
                            Spacer()
                            Text("\(feedbackText.count)/\(maxCharacters)")
                                .font(.caption)
                                .foregroundColor(feedbackText.count > maxCharacters ? .red : .secondary)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 20)
                    
                    // 提交按钮
                    Button(action: {
                        submitFeedback()
                    }) {
                        HStack {
                            if isSubmitting {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(NSLocalizedString("feedback_submit", comment: "Submit button"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(feedbackText.isEmpty || isSubmitting ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(feedbackText.isEmpty || isSubmitting)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .alert(NSLocalizedString("feedback_success_title", comment: "Success alert title"), isPresented: $showSuccessAlert) {
            Button(NSLocalizedString("common_ok", comment: "OK button")) {
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text(NSLocalizedString("feedback_success_message", comment: "Success alert message"))
        }
    }
    
    private func submitFeedback() {
        isSubmitting = true
        
        // 模拟提交过程
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isSubmitting = false
            showSuccessAlert = true
        }
    }
}

#Preview {
    FeedbackView()
}
