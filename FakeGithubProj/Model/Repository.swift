import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: Owner
    let description: String?
    let isPrivate: Bool
    let stargazersCount: Int
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case description
        case isPrivate = "private"
        case stargazersCount = "stargazers_count"
        case language
    }
}

struct Owner: Codable {
    let login: String
    let id: Int
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
    }
}