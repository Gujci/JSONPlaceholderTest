//
//  JSONPlaceholderTestTests.swift
//  JSONPlaceholderTestTests
//
//  Created by Gujgiczer Máté on 19/09/16.
//  Copyright © 2016 gujci. All rights reserved.
//

import XCTest

class JSONPlaceholderTestTests: XCTestCase {
    
    var loader: DataLoader = App.sharedInstance.request()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadingPosts() {
        let expectation = self.expectation(description: "loadin posts")
        
        loader.on(LoaderEvent.postsLoaded) { [weak self] in
            guard let _ = self?.loader.posts else {
                XCTAssert(false, "error during loading posts")
                return
            }
            expectation.fulfill()
        }
        
        loader.loadPosts()
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
