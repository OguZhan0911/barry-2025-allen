import SwiftUI
import Foundation
// 只保留struct HomeView: View及其内容，移除ViewModel和数据结构定义
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var userInfo = UserInfoManager.shared
    @State private var showLoginSheet = false
    @State private var showBankList = false
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top Logo
                HStack {
                    // FIXME: Replace with actual logo image
                    Text("Barry Allen")
//                        .font(AppFonts.title)
                        .font(.custom("Snell Roundhand", size: 28))
                        .foregroundColor(AppColors.primary)
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
                                .fill(LinearGradient(gradient: Gradient(colors: [AppColors.primary.opacity(0.8), AppColors.secondary]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(height: 140)
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Finance")
                                        .font(AppFonts.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text("Your Robust Rating Support. Find the most fit bank you need.\nSign up for better benefits and insights.")
                                        .font(AppFonts.caption)
                                        .foregroundColor(.white.opacity(0.9))
                                    Button(action: {
                                        if !userInfo.isLoggedIn {
                                            showLoginSheet = true
                                        } else {
                                            // 已登录后的操作
                                        }
                                    }) {
                                        Text("Create very loan")
                                            .font(AppFonts.caption)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 6)
                                            .background(AppColors.card)
                                            .foregroundColor(AppColors.primary)
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
                                        .font(AppFonts.subheadline)
                                }
                                VStack {
                                    // FIXME: Replace with actual icon
                                    Image(systemName: "percent")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.purple)
                                    Text("Guide")
                                        .font(AppFonts.subheadline)
                                }
                                VStack {
                                    // FIXME: Replace with actual icon
                                    Image(systemName: "checkmark.seal.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(AppColors.primary)
                                    Text("Bouns")
                                        .font(AppFonts.subheadline)
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        // Financial institution ratings
                        HStack {
                            Text("Financial institution ratings")
                                .font(AppFonts.headline)
                            Spacer()
                            Button(action: {
                                showBankList = true
                            }) {
                                Text("more")
                                    .font(AppFonts.subheadline)
                                    .foregroundColor(AppColors.primary)
                            }
                            .background(
                                NavigationLink(destination: BankListView(banks: viewModel.institutionList), isActive: $showBankList) {
                                    EmptyView()
                                }
                                .hidden()
                            )
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.institutionList, id: \.id) { institution in
                                    VStack(alignment: .center, spacing: 8) {
                                        if institution.institutionImage.hasSuffix(".svg") {
                                            if let url = URL(string: institution.institutionImage) {
                                                SVGImageView(url: url)
                                                    .frame(width: 48, height: 48)
                                                    .padding(.top, 16)
                                            } else {
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 48, height: 48)
                                                    .padding(.top, 16)
                                            }
                                        } else {
                                            AsyncImage(url: URL(string: institution.institutionImage)) { image in
                                                image.resizable().scaledToFit()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 48, height: 48)
                                            .padding(.top, 16)
                                        }
                                        Text(institution.institutionName)
                                            .font(AppFonts.subheadline)
                                            .multilineTextAlignment(.center)
                                        HStack(spacing: 2) {
                                            ForEach(0..<5) { i in
                                                Image(systemName: i < Int(institution.rating) ? "star.fill" : "star")
                                                    .resizable()
                                                    .frame(width: 12, height: 12)
                                                    .foregroundColor(AppColors.star)
                                            }
                                            Text(String(format: "%.1f score", institution.rating))
                                                .font(AppFonts.caption)
                                                .foregroundColor(AppColors.textSecondary)
                                        }
                                        Spacer(minLength: 8)
                                    }
                                    .frame(width: 140, height: 150)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(AppColors.primary.opacity(0.1))
                                    )
                                }
                            }
                        }
                        // Financial Knowledge
                        HStack {
                            Text("Financial Knowledge")
                                .font(AppFonts.headline)
                            Spacer()
                            Button(action: {/* FIXME: more knowledge */}) {
                                Text("more")
                                    .font(AppFonts.subheadline)
                                    .foregroundColor(AppColors.primary)
                            }
                        }
                        VStack(spacing: 12) {
                            ForEach(viewModel.knowledgeList, id: \.self) { item in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(item.title)
                                        .font(AppFonts.subheadline)
                                        .fontWeight(.semibold)
                                    Text(item.desc)
                                        .font(AppFonts.caption)
                                        .foregroundColor(AppColors.textSecondary)
                                    HStack(spacing: 16) {
                                        Text("Read \(item.reads)")
                                            .font(AppFonts.caption)
                                            .foregroundColor(AppColors.tagText)
                                        Text("Likes \(item.likes)")
                                            .font(AppFonts.caption)
                                            .foregroundColor(AppColors.tagText)
                                    }
                                }
                                .padding()
                                .background(AppColors.background)
                                .cornerRadius(12)
                            }
                        }
                        Spacer(minLength: 24)
                    }
                    .padding()
                }
                // Bottom TabBar
                // (已移除多余的自定义TabBar)
            }
            .background(AppColors.background.ignoresSafeArea())
            .navigationBarHidden(true)
            .sheet(isPresented: $showLoginSheet) {
                LoginView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

