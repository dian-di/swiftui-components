//
//  ShapeView.swift
//  SwiftUIComponents
//
//  Created by wuxue on 2025/8/5.
//

import SwiftUI

struct ShapeView: View {
    var body: some View {
        VStack {
            Circle()
                .union(.capsule.inset(by: 100))
                .fill(.blue)
            
            Circle()
                .lineSubtraction(.rect.inset(by: 30))
                .stroke(style: .init(lineWidth: 20, lineCap: .round))
                .padding()
            
            Circle()
                .offset(x: -100)
                .symmetricDifference(.circle.offset(x: 100))
                .fill(.red)
                .padding()
        }
    }
}

#Preview {
    ShapeView()
}
