//
//  ButtonView.swift
//  SwiftUIComponents
//
//  Created by wuxue on 2025/8/4.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        List {
            // buttonStyle
            Section {
                VStack(alignment: .leading) {
                    Button("automatic") {}.buttonStyle(.automatic)  // default
                    Button("plain") {}.buttonStyle(.plain)
                    Button("bordered") {}.buttonStyle(.bordered)
                    Button("borderedProminent") {}.buttonStyle(.borderedProminent)
                    Button("borderless") {}.buttonStyle(.borderless)
                    Button("custom blue") {}.buttonStyle(BlueButton())
                    Button("GrowingButton") {}.buttonStyle(GrowingButton())
                }
            } header: {
                Text("button_Style")
                    .font(.headline)
            }

            // role
            Section {
                VStack(alignment: .leading) {
                    Button("default") {}  // default
                    Button("cancel", role: .cancel) {}
                    Button("destructive", role: .destructive) {}
                }

            } header: {
                Text("role")
                    .font(.headline)
            }

            // buttonbordershape
            Section {
                VStack(alignment: .leading) {
                    Button("automatic") {}.buttonBorderShape(.automatic)  // default
                    Button("capsule") {}.buttonBorderShape(.capsule)
                    Button("radius 14") {}.buttonBorderShape(
                        .roundedRectangle(radius: 14)
                    )
                }.buttonStyle(.bordered)
            } header: {
                Text("button_border_shape")
                    .font(.headline)
            }
        }.listStyle(.plain)
    }
}

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(Capsule())
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    ButtonView()
}
