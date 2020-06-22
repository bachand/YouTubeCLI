//
//  JSONDecoder+YouTubeTests.swift
//  YouTubeCLIKitTests
//
//  Created by Michael Bachand on 12/7/19.
//

import Foundation
import XCTest

@testable import YouTubeCLIKit

//
///// The strategy to use in decoding dates. Defaults to `.deferredToDate`.
//open var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
//
///// The strategy to use in decoding binary data. Defaults to `.base64`.
//open var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy
//
///// The strategy to use in decoding non-conforming numbers. Defaults to `.throw`.
//open var nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy
//
///// The strategy to use for decoding keys. Defaults to `.useDefaultKeys`.
//open var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
//
///// Contextual user-provided information for use during decoding.
//open var userInfo: [CodingUserInfoKey : Any]

final class JSONDecoder_YouTubeTests: XCTestCase {

  // MARK: Internal
  override func setUp() {
    super.setUp()
    sut = JSONDecoder.makeForYouTube()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func test_configuration() {
    switch sut.dateDecodingStrategy {
    case .custom:
      // correct!
      break
    default:
      XCTFail("Unexpected date decoding strategy.")
    }

    switch sut.dataDecodingStrategy {
    case .base64:
      // This is the default.
      break
    default:
      XCTFail("Unexpected data decoding strategy.")
    }

    switch sut.nonConformingFloatDecodingStrategy {
    case .`throw`:
      // This is the default.
      break
    default:
      XCTFail("Unexpected non-conforming float decoding strategy.")
    }

    switch sut.keyDecodingStrategy {
    case .useDefaultKeys:
      // This is the default.
      break
    default:
      XCTFail("Unexpected key decoding strategy.")
    }

    // This is the default.
    XCTAssertEqual(sut.userInfo.keys.count, 0)
  }

  // MARK: Private

  private var sut: JSONDecoder!
}
