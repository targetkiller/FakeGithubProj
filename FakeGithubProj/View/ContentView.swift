
import SwiftUI

struct ContentView: View {
    @StateObject private var userSettings = UserSettings.shared
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            if userSettings.isAuthenticated {
                MainTabView()
            } else {
                LoginView()
            }
        }
        .preferredColorScheme(userSettings.isDarkMode ? .dark : .light)
    }
}
