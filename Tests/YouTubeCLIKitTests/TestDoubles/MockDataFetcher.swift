//
//  MockDataFetcher.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 1/26/20.
//

import BachandNetworking
import Foundation

// MARK: - MockDataFetcher

final class MockDataFetcher: DataFetcher {
  init(queue: DispatchQueue = .init(label: "com.bachand.MockDataFetcher")) {
    self.queue = queue
  }

  /// The data to pass to the completion handler.
  var data: Data?
  /// The response to pass to the completion handler.
  var urlResponse: URLResponse?
  /// The error to pass to the completion handler.
  var error: Error?

  private(set) var fetchCallCount = 0
  func fetch(
    _ urlRequest: URLRequest,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
  {
    fetchCallCount += 1
    queue.async { [weak self] in
      completionHandler(self?.data, self?.urlResponse, self?.error)
    }
  }

  private let queue: DispatchQueue
}
