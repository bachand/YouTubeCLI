//
//  VideoProtocol.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 12/2/19.
//

import Foundation

// MARK: - VideoProtocol

/// Abstract video.
protocol VideoProtocol {

  /// The ID of the video.
  var id: String { get }
  /// The publish time of the video.
  var publishedAt: Date { get }
  /// The title of the video.
  var title: String { get }

  /// Returns images sorted by `order`.
  ///
  /// - parameter order: The order to sort the images.
  func sortedImages(order: ImageSortOrder) -> [URL]
}

/// Convenience extensions.
extension VideoProtocol {
  /// Returns the highest-resolution image available.
  var highestResolutionImage: URL? { sortedImages(order: .descending).first }
  /// Returns the lowest-resolution image available.
  var lowestResolutionImage: URL? { sortedImages(order: .ascending).first }
  /// Returns unique images in no particular order.
  var images: Set<URL> { Set(sortedImages(order: .descending)) }
}

// MARK: - ImageSortOrder

enum ImageSortOrder {
  /// Return lower-resolution images first.
  case ascending
  /// Return higher-resolution images first.
  case descending
}
