//
//  WeddingVenueTests.swift
//  WeddingVenueTests
//
//  Created by hienng on 12/5/16.
//  Copyright © 2016 chasingkite. All rights reserved.
//

import XCTest
@testable import WeddingVenue

class WeddingVenueTests: XCTestCase {
	
	let collection = WeddingVenueCollection()
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
		collection.loadTestData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testSetFavorite() {
		let weddingVenue = collection[0]
		let otherWeddingVenue = collection[1]
		
		collection.favorite = weddingVenue
		XCTAssert(collection.isFavorite(weddingVenue))
		XCTAssertFalse(collection.isFavorite(otherWeddingVenue))
	}
	
	func testSetFavoriteNotInCollection() {
		let weddingData = ["name": "Test Wedding Venue", "priceGuide": 1, "rating": 1, "details": "Test"] as [String : Any]
		let weddingVenue = WeddingVenue(dict: weddingData as [String : AnyObject])!
		
		collection.favorite = weddingVenue
		XCTAssertNil(collection.favorite)
	}
	
	func testRemoveFavoriteFails() {
		let weddingVenue = collection[0]
		let startCount = collection.count
		
		collection.favorite = weddingVenue
		collection.removeWeddingVenue(weddingVenue)
		
		XCTAssertEqual(startCount, collection.count, "Favorite should not be removeable!")
	}
	
	func testTestDataLoadTime() {
		measure() {
			self.collection.loadTestData()
		}
	}
	
	func testCloudLoadFails() {
		let expect = expectation(description: "Expecting cloud data call to fail")
		
		collection.loadCloudTestData { (didReceiveData) -> () in
			if didReceiveData {
				XCTFail()
			} else {
				expect.fulfill()
			}
		}
		
		waitForExpectations(timeout: 3, handler: nil)
	}
	
	func testCloudLoadSucceeds() {
		class MockWeddingVenueCollection: WeddingVenueCollection {
			override var isCloudCollection: Bool {
				return true
			}
		}
		
		let collection = MockWeddingVenueCollection()
		
		let expect = expectation(description: "Expecting cloud data call to succeed!")
		
		collection.loadCloudTestData { (didReceiveData) -> () in
			if didReceiveData {
				expect.fulfill()
			} else {
				XCTFail("Cloud data call failed!")
			}
		}
		
		waitForExpectations(timeout: 3, handler: nil)
	}



	
}
