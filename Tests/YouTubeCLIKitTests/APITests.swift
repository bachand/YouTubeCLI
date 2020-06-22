//
//  APITests.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import XCTest

@testable import YouTubeCLIKit

final class YouTubeAPITests: XCTestCase {

  // MARK: Internal

  func test_makeYouTubeSearchRequest_noAdditionalQueryParameters_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeSearchRequest(apiKey: stubAPIKey)
    let expectedURLString = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=123STUBKEY"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }

  func test_makeYouTubeSearchRequest_nonNilQuery_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeSearchRequest(apiKey: stubAPIKey, query: "cats")
    let expectedURLString = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=123STUBKEY&q=cats"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }

  func test_makeYouTubeSearchRequest_nonNilMaxResults_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeSearchRequest(apiKey: stubAPIKey, maxResults: 10)
    let expectedURLString = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=123STUBKEY&maxResults=10"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }

  func test_makeYouTubeSearchRequest_maxResultsGreaterThan50_maxResultsTruncatedTo50() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeSearchRequest(apiKey: stubAPIKey, maxResults: 100)
    let expectedURLString = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=123STUBKEY&maxResults=50"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }

  func test_makeYouTubeSearchRequest_nonNilOrder_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeSearchRequest(apiKey: stubAPIKey, order: .rating)
    let expectedURLString = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=123STUBKEY&order=rating"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }

  func test_makeYouTubeSearchRequest_nonNilPageToken_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeSearchRequest(apiKey: stubAPIKey, pageToken: "ABCDEF123")
    let expectedURLString = "https://www.googleapis.com/youtube/v3/search?part=snippet&key=123STUBKEY&pageToken=ABCDEF123"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }
  
  func test_makeYouTubeVideoListRequest_noIDs_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeVideoListRequest(apiKey: stubAPIKey, ids: [])
    let expectedURLString = "https://www.googleapis.com/youtube/v3/videos?part=snippet,recordingDetails&key=123STUBKEY&id="
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }
  
  func test_makeYouTubeVideoListRequest_oneID_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeVideoListRequest(apiKey: stubAPIKey, ids: ["abc123"])
    let expectedURLString = "https://www.googleapis.com/youtube/v3/videos?part=snippet,recordingDetails&key=123STUBKEY&id=abc123"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }
  
  func test_makeYouTubeVideoListRequest_multipleIDs_hasCorrectURL() {
    // TODO: `makeYouTubeSearchRequest()` makes no guarantees about the order of query parameters.
    let request = makeYouTubeVideoListRequest(apiKey: stubAPIKey, ids: ["abc123", "456efg"])
    let expectedURLString = "https://www.googleapis.com/youtube/v3/videos?part=snippet,recordingDetails&key=123STUBKEY&id=abc123,456efg"
    XCTAssertEqual(request.url, URL(string: expectedURLString))
  }

  // MARK: Private

  private let stubAPIKey = "123STUBKEY"
}
