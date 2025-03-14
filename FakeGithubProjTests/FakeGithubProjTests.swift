//
//  FakeGithubProjTests.swift
//  FakeGithubProjTests
//
//  Created by TQ on 2025/3/13.
//

import XCTest
@testable import FakeGithubProj

final class FakeGithubProjTests: XCTestCase {
    var userSettings: UserSettings!
    
    override func setUpWithError() throws {
        userSettings = UserSettings.shared
    }
    
    override func tearDownWithError() throws {
        userSettings.username = ""
        userSettings.isAuthenticated = false
    }
    
    func testUserSettingsInitialState() {
        XCTAssertEqual(userSettings.username, "")
        XCTAssertFalse(userSettings.isAuthenticated)
    }
    
    func testUserSettingsUpdate() {
        userSettings.username = "testuser"
        userSettings.isAuthenticated = true
        
        XCTAssertEqual(userSettings.username, "testuser")
        XCTAssertTrue(userSettings.isAuthenticated)
    }
    
    func testGitHubUserDecoding() throws {
        let json = """
        {
            "login": "testuser",
            "id": 1234567,
            "avatar_url": "https://example.com/avatar.jpg",
            "name": "Test User",
            "followers": 100,
            "following": 50
        }
        """.data(using: .utf8)!
        
        let user = try JSONDecoder().decode(GitHubUser.self, from: json)
        
        XCTAssertEqual(user.login, "testuser")
        XCTAssertEqual(user.avatar_url, "https://example.com/avatar.jpg")
        XCTAssertEqual(user.name, "Test User")
        XCTAssertEqual(user.followers, 100)
        XCTAssertEqual(user.following, 50)
    }
    
    func testRepositoryDecoding() throws {
        let json = """
        {
            "id": 12345,
            "name": "test-repo",
            "full_name": "testuser/test-repo",
            "private": false,
            "description": "Test repository",
            "stargazers_count": 50,
            "language": "Swift",
            "owner": {
                "login": "testuser",
                "id": 1234567,
                "avatar_url": "https://example.com/avatar.jpg"
            }
        }
        """.data(using: .utf8)!
        
        let repo = try JSONDecoder().decode(Repository.self, from: json)
        
        XCTAssertEqual(repo.name, "test-repo")
        XCTAssertEqual(repo.fullName, "testuser/test-repo")
        XCTAssertFalse(repo.isPrivate)
        XCTAssertEqual(repo.description, "Test repository")
        XCTAssertEqual(repo.stargazersCount, 50)
        XCTAssertEqual(repo.language, "Swift")
        XCTAssertEqual(repo.owner.login, "testuser")
    }
    
    // 搜索结果测试
    func testGitHubSearchResultDecoding() throws {
        let json = """
        {
            "total_count": 1,
            "incomplete_results": false,
            "items": [{
                "id": 12345,
                "name": "test-repo",
                "full_name": "testuser/test-repo",
                "private": false,
                "description": "Test repository",
                "stargazers_count": 50,
                "language": "Swift",
                "owner": {
                    "login": "testuser",
                    "id": 1234567,
                    "avatar_url": "https://example.com/avatar.jpg"
                }
            }]
        }
        """.data(using: .utf8)!
        
        let searchResult = try JSONDecoder().decode(GitHubSearchResult.self, from: json)
        
        XCTAssertEqual(searchResult.items.count, 1)
        XCTAssertEqual(searchResult.items.first?.name, "test-repo")
    }
}
