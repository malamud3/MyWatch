//
//  APICaller_TVTests.swift
//  MyWatchTests
//
//  Created by Amir Malamud on 12/06/2023.
//

import XCTest
@testable import MyWatch

class APICaller_TVTests: XCTestCase {
    
    func testGetTrending() {
        let apiCaller = APICaller_TV.shared
        let expectation = XCTestExpectation(description: "Get trending TV shows")
        
        apiCaller.getTrending(dataPage: 1, Ganerfilter: -1) { result in
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty, "Received empty list of trending TV shows")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get trending TV shows: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetPopular() {
        let apiCaller = APICaller_TV.shared
        let expectation = XCTestExpectation(description: "Get popular TV shows")
        
        apiCaller.getPopular(dataPage: 1, Ganerfilter: -1) { result in
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty, "Received empty list of popular TV shows")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get popular TV shows: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetTopRated() {
        let apiCaller = APICaller_TV.shared
        let expectation = XCTestExpectation(description: "Get top rated TV shows")
        
        apiCaller.getTopRated(dataPage: 1, Ganerfilter: -1) { result in
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty, "Received empty list of top rated TV shows")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get top rated TV shows: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetUpcoming() {
        let apiCaller = APICaller_TV.shared
        let expectation = XCTestExpectation(description: "Get upcoming TV shows")
        
        apiCaller.getUpcoming(dataPage: 1, Ganerfilter: -1) { result in
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty, "Received empty list of upcoming TV shows")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get upcoming TV shows: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetRecentlyAdded() {
        let apiCaller = APICaller_TV.shared
        let expectation = XCTestExpectation(description: "Get recently added TV shows")
        
        apiCaller.getRecentlyAdded(dataPage: 1, Ganerfilter: -1) { result in
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty, "Received empty list of recently added TV shows")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to get recently added TV shows: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testDoSearch() {
        let apiCaller = APICaller_TV.shared
        let expectation = XCTestExpectation(description: "Do search for TV shows")
        
        apiCaller.doSearch(dataPage: 1, with: "Game of Thrones") { result in
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty, "Received empty list of search results")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to perform TV show search: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}


