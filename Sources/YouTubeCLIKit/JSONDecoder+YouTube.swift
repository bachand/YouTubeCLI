//
//  JSONDecoder+YouTube.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 12/7/19.
//

import Foundation

extension JSONDecoder {

  /// Creates a`JSONDecoder` that is configured to work well with the YouTube API.
  static func makeForYouTube() -> JSONDecoder {
    struct YouTubeDateDecodingError: Error { }

    let decoder = JSONDecoder()
    let customDecoder = { (decoder: Decoder) -> Date in
      let dateString = try decoder.singleValueContainer().decode(String.self)
      guard let date = ISO8601DateFormatter.youTube.date(from: dateString) else {
        throw(YouTubeDateDecodingError())
      }
      return date
    }
    decoder.dateDecodingStrategy = .custom(customDecoder)
    return decoder
  }
}
