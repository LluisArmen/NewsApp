//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Lluis Armengol on 23/02/2022.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {

    let newsViewModel = NewsViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // Test function to get news options and endpoint: check type
    func testGetNewsOptions() throws {
        let (endPoint, options) = newsViewModel.getNewsOptions()
        XCTAssertTrue(type(of: (endPoint?.url)) == URL?.self)
        XCTAssertTrue(type(of: options) == [URLQueryItem]?.self)
    }

    
    // Test function to get news URL: check type
    func testGetNewsURL() throws {
        XCTAssertTrue(type(of: (newsViewModel.getNewsURL())) == URL?.self)
    }
    

    // Test function to get news and store them into published var: ASYNCRONOYS functions
    func testGetNews() throws {
        let expectation = expectation(description: "\(#function)")
        newsViewModel.getNews(completion: {success, error in
            XCTAssertEqual(success, true)
            XCTAssertEqual(error, "")
            XCTAssertTrue(self.newsViewModel.articles.count>0)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    
    // Test function to WRONGLY get news and store them into published var: ASYNCRONOYS functions
    func testGetNewsFail() throws {
        let expectation = expectation(description: "\(#function)")
        newsViewModel.getNews([URLQueryItem(name: "itWillFail", value: "fr")], completion: {success, error in
            XCTAssertEqual(success, false)
            XCTAssertFalse(error == "")
            XCTAssertTrue(self.newsViewModel.articles.count==0)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3)
    }
    
    

}
