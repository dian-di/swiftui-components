//
//  EffectView.swift
//  SwiftUIComponents
//
//  Created by wuxue on 2025/7/26.
//

import SwiftUI

struct EffectView: View {
    var body: some View {
        BlendScreenView()
    }
}

struct BlendScreenView: View {
    @State private var amount = 0.5
    var body: some View {
        

        VStack {
            ZStack {
                Image("dog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
//                    .saturation(amount)
                    .blur(radius: (1 - amount) * 20)
//                Circle()
//                    .fill(.red)
//                    .frame(width: 200 * amount)
//                    .offset(x: -50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(.green)
//                    .frame(width: 200 * amount)
//                    .offset(x: 50, y: -80)
//                    .blendMode(.screen)
//
//                Circle()
//                    .fill(.blue)
//                    .frame(width: 200 * amount)
//                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

#Preview {
    EffectView()
}
