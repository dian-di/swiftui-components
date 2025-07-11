//https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-scrolling-pages-of-content-using-tabviewstyle
import SwiftUI

struct WithDotView: View {
    var body: some View {
        TabView {
            Text("1")
            Text("2")
            Text("3")
            Text("4")
        }
        // without index dot
        // .tabViewStyle(.page)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview("with dot") {
    WithDotView()
}
