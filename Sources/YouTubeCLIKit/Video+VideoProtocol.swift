//
//  Models+Service.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import Foundation

extension Video: VideoProtocol {

  func sortedImages(order: ImageSortOrder) -> [URL] {
    let images: [URL?]
    switch order {
    case .ascending:
      images = [
        imageDefault,
        imageMedium,
        imageHigh,
        imageStandard,
        imageMaxRes,
      ]
    case .descending:
      images = [
        imageMaxRes,
        imageStandard,
        imageHigh,
        imageMedium,
        imageDefault,
      ]
    }
    return images.compactMap({ $0 })
  }
}
