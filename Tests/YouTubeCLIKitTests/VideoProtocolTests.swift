//
//  VideoProtocolTests.swift
//  YouTubeCLIKitTests
//
//  Created by Michael Bachand on 12/2/19.
//

import Foundation
import XCTest

@testable import YouTubeCLIKit

final class VideoProtocolTests: XCTestCase {

  func test_sortedImages_ascending_ordersCorrectly() {
    let sut: VideoProtocol = stubVideo(
      imageDefault: URL(string: "default.png"),
      imageMedium: URL(string: "medium.png"),
      imageHigh: URL(string: "high.png"),
      imageStandard: URL(string: "standard.png"),
      imageMaxRes: URL(string: "maxRes.png"))
    let expectedImages = [
      "default.png",
      "medium.png",
      "high.png",
      "standard.png",
      "maxRes.png",
    ]
    let images = sut.sortedImages(order: .ascending).map({ $0.absoluteString })
    XCTAssertEqual(expectedImages, images)
  }

  func test_sortedImages_descending_ordersCorrectly() {
    let sut: VideoProtocol = stubVideo(
      imageDefault: URL(string: "default.png"),
      imageMedium: URL(string: "medium.png"),
      imageHigh: URL(string: "high.png"),
      imageStandard: URL(string: "standard.png"),
      imageMaxRes: URL(string: "maxRes.png"))
    let expectedImages = [
      "maxRes.png",
      "standard.png",
      "high.png",
      "medium.png",
      "default.png",
    ]
    let images = sut.sortedImages(order: .descending).map({ $0.absoluteString })
    XCTAssertEqual(expectedImages, images)
  }

  private func stubVideo(
    imageDefault: URL?,
    imageMedium: URL?,
    imageHigh: URL?,
    imageStandard: URL?,
    imageMaxRes: URL?) -> Video
  {
    Video(
      kind: "kind",
      etag: "etag",
      id: "id",
      title: "title",
      tags: nil,
      imageDefault: imageDefault,
      imageMedium: imageMedium,
      imageHigh: imageHigh,
      imageStandard: imageStandard,
      imageMaxRes: imageMaxRes,
      publishedAt: Date())
  }
}
