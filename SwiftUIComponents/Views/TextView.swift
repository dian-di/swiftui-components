//
//  TextView.swift
//  SwiftUIComponents
//
//  Created by wuxue on 2025/8/5.
//

import SwiftUI

struct TextView: View {
    @State private var bio = "About me"
    @State private var dayNight = "day"
    var body: some View {
        VStack {
            TextField("Describe yourself", text: $bio, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(5, reservesSpace: true)
            TextField("Describe yourself", text: $bio)
                .textFieldStyle(.roundedBorder)
            TextField("Describe yourself", text: $bio)
                .textFieldStyle(.automatic)
            Text(bio)
        }
        .padding()
        Text("SwiftUI ")
            .foregroundStyle(.red)
            + Text("is ")
            .foregroundStyle(.orange)
            .fontWeight(.black)
            + Text("awesome")
            .foregroundStyle(.blue)
        ControlGroup {
            Button("First") {}
            Button("Second") {}
            Button("Third") {}
        }
        .padding()
        Picker("", selection: $dayNight) {
            Text("Day").tag("day")
            Text("Night").tag("night")
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

#Preview {
    TextView()
}
