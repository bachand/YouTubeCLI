//
//  ServiceTests.swift
//  YouTubeCLIKitTests
//
//  Created by Michael Bachand on 11/30/19.
//

import BachandNetworking
import XCTest

@testable import YouTubeCLIKit

// MARK: - ServiceTests

final class ServiceTests: XCTestCase {

  // MARK: Internal

  override func setUp() {
    mockDataFetcher = MockDataFetcher()
    service = DefaultService(dataFetcher: mockDataFetcher)
  }

  override func tearDown() {
    mockDataFetcher = nil
    service = nil
  }

  func test_executeQuery_makesAtLeastOneFetch() {
    let expecatation = expectation(description: #function)
    XCTAssertEqual(mockDataFetcher.fetchCallCount, 0)
    service.executeQuery(stubQuery()) { _ in
      expecatation.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    XCTAssert(mockDataFetcher.fetchCallCount >= 1)
  }

  func test_executeQuery_noData_completesWithEmptyResult() {
    mockDataFetcher.data = nil
    let expecatation = expectation(description: #function)
    XCTAssertEqual(mockDataFetcher.fetchCallCount, 0)
    service.executeQuery(stubQuery()) { result in
      XCTAssertTrue(result.items.isEmpty)
      expecatation.fulfill()
    }
    waitForExpectations(timeout: 1.0)
  }

  // MARK: Private

  private var mockDataFetcher: MockDataFetcher!
  private var service: Service!
  private let stubAPIKey = "123STUBKEY"

  private func stubQuery() -> Query { Query(apiKey: stubAPIKey, sort: .relevance) }
}
