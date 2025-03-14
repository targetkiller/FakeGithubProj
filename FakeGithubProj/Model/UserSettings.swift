class UserSettings: ObservableObject {
    @Published var username: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var isDarkMode: Bool = false
    
    static let shared = UserSettings()
    private init() {
        isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    func toggleDarkMode() {
        isDarkMode.toggle()
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
}