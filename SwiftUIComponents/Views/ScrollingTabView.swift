import SwiftUI

struct ScrollingTabView: View {
    @State private var selectedTabIndex = 0
    @State private var selectedTabID: Int? = nil

    let tabTitles = [
        "Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5", "Tab 6", "Tab 7", "Tab 8",
        "Tab 9", "Tab 10",
    ]

    var body: some View {
        GeometryReader(content: { geometry in
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(0..<tabTitles.count, id: \.self) { index in
                            Button(action: {
                                withAnimation {
                                    selectedTabIndex = index
                                    selectedTabID = index
                                }
                            }) {
                                Text(tabTitles[index])
                                    .font(.headline)
                                    .foregroundColor(
                                        selectedTabIndex == index
                                            ? .red : .black
                                    )
                                    .frame(width: 60)
                            }
                        }
                    }

                }
                .scrollPosition(id: $selectedTabID, anchor: .center)
                .frame(height: 50)

                // Content views for each tab
                TabView(selection: $selectedTabIndex) {
                    ForEach(0..<tabTitles.count, id: \.self) { index in
                        ZStack {
                            Color(uiColor: .systemGray6)
                            Text("Content for \(tabTitles[index])")
                                .font(.title)
                                .tag(index)
                        }
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(
                    PageIndexViewStyle(backgroundDisplayMode: .never)
                )
            }

        })
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: selectedTabIndex) { oldValue, newValue in
            withAnimation {
                selectedTabIndex = newValue
                selectedTabID = newValue
            }
        }
    }
}

#Preview {
    ScrollingTabView()
}
