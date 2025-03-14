
import SwiftUI

struct ReposView: View {
    @State private var repositories: [Repository]?
    @StateObject private var userSettings = UserSettings.shared
    
    var body: some View {
        VStack {
            if let repositories = repositories {
                List(repositories, id: \.id) { repo in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(repo.name)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(hex: "333333"))
                        
                        if let description = repo.description {
                            Text(description)
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "555555"))
                                .lineLimit(2)
                        }
                        
                        HStack(spacing: 16) {
                            if let language = repo.language {
                                HStack(spacing: 4) {
                                    Circle()
                                        .fill(languageColor(for: language))
                                        .frame(width: 8, height: 8)
                                    Text(language)
                                }
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star")
                                Text("\(repo.stargazersCount)")
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "666666"))
                    }
                    .padding(.vertical, 8)
                }
            } else {
                ProgressView("Fetching Repositories...")
                    .onAppear(perform: fetchUserRepos)
            }
        }
        .navigationTitle("My Repositories")
    }
    
    private func fetchUserRepos() {
        let url = URL(string: "https://api.github.com/users/\(userSettings.username)/repos")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode([Repository].self, from: data)
                DispatchQueue.main.async {
                    repositories = results
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}

