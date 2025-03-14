import XCTest

final class FakeGithubProjUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testLoginViewElements() throws {
        XCTAssertTrue(app.images["github_logo"].exists)
        XCTAssertTrue(app.textFields["Username"].exists)
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        XCTAssertTrue(app.buttons["Login"].exists)
        XCTAssertTrue(app.buttons["Login with Face ID"].exists)
    }
    
    func testLoginFlow() throws {
        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]
        
        usernameField.tap()
        usernameField.typeText("testuser")
        
        passwordField.tap()
        passwordField.typeText("password")
        
        loginButton.tap()
        
        XCTAssertTrue(app.navigationBars["GitHub Home"].waitForExistence(timeout: 5))
    }
    
    func testInvalidLogin() throws {
        let usernameField = app.textFields["Username"]
        let passwordField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]
        
        usernameField.tap()
        usernameField.typeText("testuser")
        
        passwordField.tap()
        passwordField.typeText("wrongpassword")
        
        loginButton.tap()
        
        XCTAssertTrue(app.staticTexts["Invalid password."].exists)
    }
    
    func testHomeViewNavigation() throws {
        try testLoginFlow()
        
        let reposButton = app.buttons["See Repositories"]
        XCTAssertTrue(reposButton.exists)
        reposButton.tap()
        
        XCTAssertTrue(app.navigationBars["My Repositories"].waitForExistence(timeout: 5))
    }
    
    func testSearchFunction() throws {
        try testLoginFlow()
        
        app.tabBars.buttons["Search"].tap()
        
        let searchField = app.textFields["Type something to search"]
        XCTAssertTrue(searchField.exists)
        
        searchField.tap()
        searchField.typeText("Swift\n")
        
        let predicate = NSPredicate(format: "count > 0")
        let expectation = expectation(for: predicate, evaluatedWith: app.cells, handler: nil)
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogout() throws {
        try testLoginFlow()
        
        let logoutButton = app.buttons["Logout"]
        XCTAssertTrue(logoutButton.exists)
        logoutButton.tap()
        
        let confirmButton = app.alerts["Sign Out"].buttons["Sign Out"]
        XCTAssertTrue(confirmButton.waitForExistence(timeout: 5))
        confirmButton.tap()
        
        XCTAssertTrue(app.textFields["Username"].waitForExistence(timeout: 5))
    }
}
