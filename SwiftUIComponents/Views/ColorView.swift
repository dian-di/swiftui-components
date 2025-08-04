//
//  ColorView.swift
//  SwiftUIComponents
//
//  Created by wuxue on 2025/7/30.
//

import SwiftUI

struct ColorView: View {
    var body: some View {

        VStack {
            ZStack {
                Color.red.frame(width: 200, height: 200)
                Text("Your content")
                Color(red: 1, green: 0.8, blue: 0)
//                LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
//                LinearGradient(stops: [
//                    Gradient.Stop(color: .white, location: 0.45),
//                    Gradient.Stop(color: .black, location: 0.55),
//                ], startPoint: .top, endPoint: .bottom)
                
//                LinearGradient(stops: [
//                    .init(color: .white, location: 0.45),
//                    .init(color: .black, location: 0.55),
//                ], startPoint: .top, endPoint: .bottom)
                
//                RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
                AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
            }
//            .background(.red)

            ZStack {
//                Color.red.frame(width: 200, height: 200)
                Color.blue
                    .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200)

                Text("Your content")
                        .foregroundStyle(.secondary)
                        .padding(50)
//                        .background(.ultraThinMaterial)
                        .background(.red.gradient)
//                    .background(.red)
//                LinearGradient(stops: [
//                    Gradient.Stop(color: .white, location: 0.45),
//                    Gradient.Stop(color: .black, location: 0.55),
//                ], startPoint: .top, endPoint: .bottom)
            }
        }.ignoresSafeArea()

    }
}

#Preview {
    ColorView()
}
