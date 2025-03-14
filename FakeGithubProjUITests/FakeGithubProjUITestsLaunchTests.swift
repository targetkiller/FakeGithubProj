//
//  FakeGithubProjUITestsLaunchTests.swift
//  FakeGithubProjUITests
//
//  Created by TQ on 2025/3/13.
//

import XCTest

final class FakeGithubProjUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.images["github_logo"].exists)
        XCTAssertTrue(app.textFields["Username"].exists)
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Login Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testLaunchOrientation() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Portrait Mode"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        XCUIDevice.shared.orientation = .landscapeLeft
        
        let landscapeAttachment = XCTAttachment(screenshot: app.screenshot())
        landscapeAttachment.name = "Landscape Mode"
        landscapeAttachment.lifetime = .keepAlways
        add(landscapeAttachment)
    }
}
