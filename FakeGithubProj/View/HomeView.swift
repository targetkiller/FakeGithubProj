
import SwiftUI
import Kingfisher

struct HomeView: View {
    @Environment(\.selectedTab) var selectedTab
    @StateObject private var userSettings = UserSettings.shared
    @State private var user: GitHubUser?
    @State private var showLogoutAlert = false  // 添加在其他 State 变量后面
    
    var body: some View {
        VStack {
            if let user = user {
                Avatar(user: user)
                    .padding(.bottom, 20)

                Button("See Repositories") {
                    selectedTab.wrappedValue = 1
                }
                .foregroundColor(.accentColor)
                
                Button("Logout") {
                    showLogoutAlert = true
                }
                .padding(.top, 20)
                .foregroundColor(.red)
                .alert("Sign Out", isPresented: $showLogoutAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Sign Out", role: .destructive) {
                        userSettings.username = ""
                        userSettings.isAuthenticated = false
                    }
                } message: {
                    Text("Are you sure you want to sign out?")
                }

            } else {
                ProgressView("Fetching GitHub User...")
                    .onAppear(perform: fetchGitHubUser)
            }
        }
        .navigationTitle("GitHub Home")
        .background(Color(.systemBackground))
    }
    
    private func fetchGitHubUser() {
        guard !userSettings.username.isEmpty else { return }
        let url = URL(string: "https://api.github.com/users/\(userSettings.username)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let fetchedUser = try JSONDecoder().decode(GitHubUser.self, from: data)
                DispatchQueue.main.async {
                    user = fetchedUser
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
