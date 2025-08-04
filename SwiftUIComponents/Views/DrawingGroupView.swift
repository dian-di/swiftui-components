//
//  DrawingGroupView.swift
//  SwiftUIComponents
//
//  Created by wuxue on 2025/7/25.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(LinearGradient(
                        gradient: Gradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 2)
            }
        }.drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct DrawingGroupView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct DemoView: View {
    var body: some View {
        ZStack {
//            Image("dog").colorMultiply(.red)
            Image("dog").mask(Circle().fill(Color.black))

//            Rectangle()
//                .fill(.red)
//                .blendMode(.multiply)
        }
        .frame(width: .infinity, height: 500)
        .clipped()
    }
}

#Preview {
//    DrawingGroupView()
    DemoView()
}
