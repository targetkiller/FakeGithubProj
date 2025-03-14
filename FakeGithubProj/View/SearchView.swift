
import SwiftUI

struct SearchView: View {
    @State private var repositories: [Repository] = []
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Type something to search", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onSubmit {
                        searchRepositories()
                    }
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        repositories = []
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding()
            
            if isSearching {
                ProgressView()
                Spacer()
            } else {
                if repositories.isEmpty {
                    Spacer()
                    Text("Try to search 'Swift'?")
                            .foregroundColor(Color(hex: "333333"))
                    Spacer()
                } else {
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
                    
                    Spacer()
                }
            }
        }
        .navigationTitle("Search GitHub")
    }
    
    private func searchRepositories() {
        guard !searchText.isEmpty else { return }
        
        isSearching = true
        repositories = []
        
        let query = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "https://api.github.com/search/repositories?q=\(query)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            defer { 
                DispatchQueue.main.async {
                    isSearching = false
                }
            }
            
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(GitHubSearchResult.self, from: data)
                DispatchQueue.main.async {
                    repositories = results.items
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
