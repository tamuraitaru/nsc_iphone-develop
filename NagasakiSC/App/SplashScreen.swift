//
//  SplashScreen.swift
//  NagasakiSC
//
//  Created by Masaru Iida on 2024/04/05.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isSplashScreenActive: Bool

    var body: some View {
      ZStack {
        Image("AppLogo")
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 100)
          .opacity(isSplashScreenActive ? 1.0 : 0.0)
        VStack {
          // App name or logo
        }
      }
      .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          withAnimation {
            isSplashScreenActive = false
          }
        }
      }
    }
}
