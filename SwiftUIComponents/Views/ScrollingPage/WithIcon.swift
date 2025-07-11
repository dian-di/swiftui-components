//https://www.createwithswift.com/exploring-tab-view-styles-in-swiftui/
import SwiftUI

struct BoatView: View {
    var body: some View {
        VStack {
            Image(systemName: "sailboat")
            Text("Sailboat")
        }
    }
}

struct WindConditionView: View {
    var body: some View {
        Image(systemName: "wind")
        Text("Wind")
    }
}

struct WaterConditionView: View {
    var body: some View {
        Image(systemName: "water.waves")
        Text("Water")
    }
}

struct WithIconView: View {
    var body: some View {
        TabView {
            Tab("Boat", systemImage: "sailboat") {
                BoatView()
            }

            Tab("Wind", systemImage: "wind") {
                WindConditionView()
            }

            Tab("Sea", systemImage: "water.waves") {
                WaterConditionView()
            }
            TabSection {
                Tab("Maps", systemImage: "map") {
                    Text("Maps")
                }
                Tab("Compass", systemImage: "safari") {
                    Text("Compass")
                }
            } header: {
                Label("Navigation", systemImage: "folder")
            }
            .sectionActions {
                Button("Add new destination") {}
            }
        }
        //        .tabViewStyle(UIDevice.current.userInterfaceIdiom == .phone ? .page(indexDisplayMode: .always): .sidebarAdaptable)
        //        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .tabViewStyle(.sidebarAdaptable)
        .tabViewSidebarBottomBar {
            Label("User", systemImage: "person.circle")
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview("with icon") {
    WithIconView()
}
