//
//  RedditFeedTests.swift
//  Reddit-Prototype-iOSTests
//
//  Created by Basem Emara on 2020-12-11.
//

import XCTest

class RedditFeedTests: XCTestCase {
    
    func testFeedWebServiceResponse() throws {
        guard let path = Bundle(for: self.classForCoder).path(forResource: "reddit_feed", ofType: "json")
            else { fatalError("Can't find search.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let feedItemsData = try JSONDecoder().decode(FeedItemsData.self, from: data)
    
        XCTAssertGreaterThan(feedItemsData.feedItems.count, 5)
        XCTAssertGreaterThan(feedItemsData.afterLink.count, 0)
        XCTAssertEqual(feedItemsData.feedItems.count, 25)
        
        XCTAssertNotNil(feedItemsData.afterLink)
        XCTAssertNotNil(feedItemsData.feedItems.first)
        XCTAssertNotNil(feedItemsData.feedItems.first?.title)
        XCTAssertNotNil(feedItemsData.feedItems.first?.thumbnail)
        XCTAssertNotNil(feedItemsData.feedItems.first?.score)
        XCTAssertNotNil(feedItemsData.feedItems.first?.commentsNumber)
        XCTAssertNotNil(feedItemsData.feedItems.first?.thumbnailWidth)
        XCTAssertNotNil(feedItemsData.feedItems.first?.thumbnailHeight)
        
        guard let feedItem = feedItemsData.feedItems.first else { return }
        XCTAssertEqual(feedItem.title, "Star Wars on Twitter: Hayden Christensen returns as Darth Vader, joining Ewan McGregor in OBI-WAN KENOBI")
        XCTAssertEqual(feedItem.thumbnail, "https://b.thumbs.redditmedia.com/YrqDO1pLGlTfkCH1AVMfUOSoqiCjPgC7_0PrCB3M4Jc.jpg")
        XCTAssertEqual(feedItem.score, 49199)
        XCTAssertEqual(feedItem.commentsNumber, 2401)
        XCTAssertEqual(feedItem.thumbnailWidth, 140)
        XCTAssertEqual(feedItem.thumbnailHeight, 78)
    }

    func testMockFeedWebService() throws {
        MockFeedWebService.downloadFirstPageData { feedItemsData in
            XCTAssertGreaterThan(feedItemsData.feedItems.count, 0)
        } failure: { error in
            
        }
        
        MockFeedWebService.downloadNextPageData(afterLink: "t3_kapx65") { feedItemsData in
            
        } failure: { error in
            XCTAssertNotNil(error)
        }
    }
    
    func testHeightForCell() throws {
        let feedItem = FeedItem(title: "The boss is really riding me today",
                                thumbnail: "https://b.thumbs.redditmedia.com/C014uWggxt7qQ2ti6oTQwXReP4HsendQg4iL-K9I9Ok.jpg",
                                score: 52388,
                                commentsNumber: 800,
                                thumbnailWidth: 140,
                                thumbnailHeight: 140)
        var feedItemViewModel = FeedItemViewModel(model: feedItem)
        feedItemViewModel.deviceScreenWidth = 390.0
        
        XCTAssertEqual(feedItemViewModel.heightForCell(), 352)
    }
}
