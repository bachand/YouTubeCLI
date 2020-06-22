//
//  Query.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import Foundation

// MARK: - QueryProtocol

/// An interface for a query.
public protocol QueryProtocol {
  /// The API key to use to make the query.
  var apiKey: String { get }
  /// The sort order of the results.
  var sort: Sort { get }
  /// The text to query for.
  var text: String? { get }
}

// MARK: - Sort

/// The possible sort orders.
public enum Sort {
  /// Most "relevant" items first, as determined by YouTube.
  case relevance
  /// Most recent items first based on the creation date.
  case newest
}

// MARK: - Query

/// A concrete query.
public struct Query: QueryProtocol {

  public init(apiKey: String, sort: Sort, text: String? = nil) {
    self.apiKey = apiKey
    self.sort = sort
    self.text = text
  }

  public let sort: Sort
  public let apiKey: String
  public let text: String?
}
