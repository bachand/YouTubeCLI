//
//  ISO8601DateFormatterTests.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 12/4/19.
//

import Foundation
import XCTest

@testable import YouTubeCLIKit

// MARK: - ServiceTests

final class ISO8601DateFormatter_YouTubeTests: XCTestCase {

  func test_youTube_stringWithoutFractionalSeconds_decodes() {
    let date = ISO8601DateFormatter.youTube.date(from: "1970-01-01T00:20:30Z")
    let expectedDate = Date(timeIntervalSince1970: 20 * 60 + 30)
    XCTAssertEqual(date, expectedDate)
  }

  func test_youTube_stringWithFractionalSeconds_doesNotDecode() {
    let date = ISO8601DateFormatter.youTube.date(from: "2019-09-23T09:00:11.000Z")
    XCTAssertNil(date)
  }

  func test_youTube_nonDateString_doesNotDecode() {
    let date = ISO8601DateFormatter.youTube.date(from: "notADate")
    XCTAssertNil(date)
  }

  func test_youTube_encode() {
    let date = Date(timeIntervalSince1970: 24 * 60 * 60 + 20)
    let dateString = ISO8601DateFormatter.youTube.string(from: date)
    XCTAssertEqual(dateString, "1970-01-02T00:00:20Z")
  }
}
