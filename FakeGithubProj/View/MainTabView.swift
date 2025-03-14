
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("User Profile", systemImage: "house.fill")
                }
                .tag(0)
            
            ReposView()
                .tabItem {
                    Label("Repositories", systemImage: "folder.fill")
                }
                .tag(1)
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(2)
        }
        .environment(\.selectedTab, $selectedTab)
    }
}
