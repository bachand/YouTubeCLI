//
//  QueryTests.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import XCTest

@testable import YouTubeCLIKit

final class QueryTests: XCTestCase {
  func testExample() {
    XCTAssertNotNil(Query(apiKey: "123STUBKEY", sort: .relevance))
  }
}
