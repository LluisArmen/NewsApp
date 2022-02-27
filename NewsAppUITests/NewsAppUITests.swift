//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Lluis Armengol on 23/02/2022.
//

import XCTest

class NewsAppUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // Test the launch of the app
    func testAppLaunch() throws {
        let title = app.staticTexts["Welcome"]
        let description = app.staticTexts["With this app you can view the latest news obtained from https://newsapi.org"]
        let options = app.staticTexts["The default Search Options are: \n language = fr"]
        let getNewsButton = app.buttons["Get the News !"]
        XCTAssertTrue(title.exists)
        XCTAssertTrue(description.exists)
        XCTAssertTrue(options.exists)
        XCTAssertTrue(getNewsButton.exists)
    }
    
    
    // Test that the news are properly loaded by checking the elements displayed in the screen
    func testLoadNewsFromAPI() throws {
        let getNewsButton = app.buttons["Get the News !"]
        getNewsButton.tap()
        let message1 = app.staticTexts["Number of Articles:"].waitForExistence(timeout: 5)
        let showArticlesButton = app.buttons["Show Articles"].waitForExistence(timeout: 5)
        let restartButton = app.buttons["Restart"].waitForExistence(timeout: 5)
        XCTAssertTrue(message1)
        XCTAssertTrue(showArticlesButton)
        XCTAssertTrue(restartButton)
    }
    
    
    // Test the reset button to start over
    func testLoadNewsReset() throws {
        let getNewsButton = app.buttons["Get the News !"]
        getNewsButton.tap()
        _ = app.buttons["Restart"].waitForExistence(timeout: 5.0)
        app.buttons["Restart"].tap()
        let expectation = expectation(
            for: NSPredicate(format: "exists == FALSE"),
            evaluatedWith: app.buttons["Restart"],
            handler: .none
        )
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(result, .completed)
    }
    
    
    // Test that the articles are shown in a lis when tapped the button
    func testShowArticles() throws {
        app.buttons["Get the News !"].tap()
        _ = app.buttons["Show Articles"].waitForExistence(timeout: 5)
        app.buttons["Show Articles"].tap()
        let navBar = app.navigationBars["Your Articles"].staticTexts["Your Articles"].waitForExistence(timeout: 5)
        XCTAssertTrue(navBar)
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count > 0)
    }
    
    
    // Test that the detail of the article is properly displayed when tapping a row of the list
    func testShowArticleDetail() throws {
        // tapp the button
        app.buttons["Get the News !"].tap()
        // wait until articles are loaded and next button is displayed
        _ = app.buttons["Show Articles"].waitForExistence(timeout: 5)
        // tap button
        app.buttons["Show Articles"].tap()
        // wait until navigation bar is displayed from other view
        _ = app.navigationBars["Your Articles"].staticTexts["Your Articles"].waitForExistence(timeout: 5)
        let articlesTable = app.tables
        // tap first element of the list
        articlesTable.cells.element(boundBy: 0).tap()
        // check that the title of the article exists is correct
        let myScrollView = app.scrollViews.firstMatch
        let myScrollViewText = myScrollView.staticTexts
        let myScrollViewTitle = myScrollViewText.firstMatch
        XCTAssertTrue(myScrollViewTitle.exists)
        XCTAssertFalse(myScrollViewTitle.label == "No title")
    }

}
