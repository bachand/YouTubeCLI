//
//  ServiceInterface.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 12/7/19.
//

// MARK: - Service

/// Provides access to YouTube.
public protocol Service {
  /// - Parameter query: The query to execute.
  /// - Parameter completionHandler: Invoked on an arbitrary query when the query has finished executing.
  func executeQuery(_ query: QueryProtocol, completionHandler: @escaping (QueryResult) -> Void)
}

// MARK: - QueryResult

/// The result of a YouTube query.
public struct QueryResult {

  public struct Item {
    /// The ID of the fetched video.
    public let id: String
    /// The title of the fetched video.
    public let title: String?
    /// The highest-resolution image of the fetched video.
    public let imageURL: String?
    /// The publish date of the fetched video.
    public let publishDate: String?

    /// Constructs a partial item to be used when the full fetch does not complete successfully.
    static func makePartial(with id: String) -> Self {
      Item(id: id, title: nil, imageURL: nil, publishDate: nil)
    }
  }

  // MARK: Public

  public let items: AnyCollection<Item>
}
