//
//  TutorialView.swift
//  NagasakiSC
//
//  Created by 藤田優作 on 2024/03/18.
//

import SwiftUI
import SafariServices

struct TutorialView: View {
    @ObservedObject var viewModel = TutorialViewModel()
    @ObservedObject var webViewModel = WebViewModel()
    @State private var buttonOffset: CGFloat = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    let screenWidth = Int( UIScreen.main.bounds.size.width)
    let screenHeight = Int(UIScreen.main.bounds.size.height)
    @State private var currentPage: Int = 0

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    if viewModel.currentPageIndex == 0 || viewModel.currentPageIndex == 6 {
                        Image("app_back")
                            .resizable()
                            .scaledToFill()
                    }
                    VStack(spacing: 0) {
                        TabView(selection: $viewModel.currentPageIndex) {
                            ForEach(pages) { page in
                                VStack {
                                    PageView(page: page)
                                }
                                .tag(page.tag)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .animation(.easeInOut, value: viewModel.currentPageIndex)
                        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                        .tabViewStyle(PageTabViewStyle())
                        .onAppear {
                            dotAppearance.currentPageIndicatorTintColor = .black
                            dotAppearance.pageIndicatorTintColor = .gray
                        }
                        if viewModel.currentPageIndex == 0 {
                            Button {
                                viewModel.incrementPage()
                            } label: {
                                CustomBlackButton(title: "次へ")
                            }
                            Button {
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .padding(.leading, 13)
                                    Spacer()
                                    Text("")
                                    Spacer()
                                }
                            }
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.white)
                            .border(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.top, 10)
                            .padding(.bottom, buttonOffset)
                            .hidden()
                        } else if viewModel.currentPageIndex == 1 {
                            Button {
                                viewModel.incrementPage()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("次へ")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.leading, 26)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 13)
                                }
                            }
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.black)
                            .border(Color.black)
                            .cornerRadius(100)
                            Button {
                                viewModel.decrementPage()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .padding(.leading, 13)
                                    Spacer()
                                    Text("戻る")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.trailing, 26)
                                    Spacer()
                                }
                            }
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.white)
                            .border(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.top, 10)
                            .padding(.bottom, 16) // 画面の下から16pxの余白を追加
                        } else if viewModel.currentPageIndex == 2 {
                            Button {
                                viewModel.incrementPage()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("次へ")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.leading, 26)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 13)
                                }
                            }
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.black)
                            .border(Color.black)
                            .cornerRadius(100)
                            Button {
                                viewModel.decrementPage()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .padding(.leading, 13)
                                    Spacer()
                                    Text("戻る")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.trailing, 26)
                                    Spacer()
                                }
                            }
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.top, 10)
                            .padding(.bottom, 16) // 画面の下から16pxの余白を追加
                        } else if viewModel.currentPageIndex == 3 {
                            Button {
                                viewModel.incrementPage()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("次へ")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.leading, 26)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 13)
                                }
                            }
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.black)
                            .border(Color.black)
                            .cornerRadius(100)
                            Button {
                                viewModel.decrementPage()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .padding(.leading, 13)
                                    Spacer()
                                    Text("戻る")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.trailing, 26)
                                    Spacer()
                                }
                            }
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.white)
                            .border(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.top, 10)
                            .padding(.bottom, 16)
                        } else if viewModel.currentPageIndex == 4 {
                            Button {
                                viewModel.incrementPage()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("次へ")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.leading, 26)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 13)
                                }
                            }
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.black)
                            .border(Color.black)
                            .cornerRadius(100)
                            Button {
                                viewModel.decrementPage()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .padding(.leading, 13)
                                    Spacer()
                                    Text("戻る")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.trailing, 26)
                                    Spacer()
                                }
                            }
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.white)
                            .border(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.top, 10)
                            .padding(.bottom, 16)
                        } else if viewModel.currentPageIndex == 5 {
                            Button {
                                viewModel.incrementPage()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("次へ")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.leading, 26)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding(.trailing, 13)
                                }
                            }
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.black)
                            .border(Color.black)
                            .cornerRadius(100)
                            Button {
                                viewModel.decrementPage()
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .padding(.leading, 13)
                                    Spacer()
                                    Text("戻る")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .padding(.trailing, 26)
                                    Spacer()
                                }
                            }
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .frame(height: 48)
                            .background(Color.white)
                            .border(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .padding(.top, 10)
                            .padding(.bottom, 16)
                        } else if viewModel.currentPageIndex == 6 {
                            NavigationLink(destination: AuthView(), isActive: $viewModel.isAuthViewActive) {
                                EmptyView()
                            }
                            Button {
                                viewModel.toAuthView()
                            } label: {
                                CustomBlackButton(title: "ログイン or 新規会員登録")
                            }
                            NavigationLink(
                                destination: NotificationPermissionView(),
                                label: {
                                    Text("ゲスト会員で利用する")
                                        .font(Font.custom("Hiragino Kaku Gothic Pro", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.black)
                                        .frame(width: UIScreen.main.bounds.width - 40)
                                        .frame(height: 48)
                                        .background(Color.white)
                                        .border(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 100)
                                                .stroke(Color.black, lineWidth: 2)
                                        )
                                        .padding(.top, 10)
                                        .padding(.bottom, buttonOffset)
                                }
                            ).simultaneousGesture(TapGesture().onEnded{
                                viewModel.callUserRegisterAPI()
                           })
                        }
                    }
                    .navigationBarBackButtonHidden()
                    .onAppear {
                        let aspectRatio = geometry.size.width / geometry.size.height
                        let uiScreenAspectRatio = screenWidth / screenHeight
                          // ここで縦横比に応じてボタンの位置を調整するロジックを追加
//                        print("画面比 width:\(geometry.size.width) hegiht: \(geometry.size.height) 比: \(aspectRatio)")
//                        print("画面比 width:\(screenWidth) hegiht: \(screenHeight) 比: \(aspectRatio)")
                        if 0.51 <= aspectRatio && aspectRatio <= 0.518 {
                            // iPhone15Pro
                            buttonOffset = 100
                        } else if 0.579 <= aspectRatio && aspectRatio <= 0.58 {
                            // iPhoneSE 3rd iOS17.4
                            buttonOffset = 180
                        } else if Int(0.560) <= uiScreenAspectRatio && uiScreenAspectRatio <= Int(0.563) {
                            // iPhoneSE 3rd iOS15.4
                            buttonOffset = 280
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    TutorialView()
}
