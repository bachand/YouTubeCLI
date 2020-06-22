//
//  ISO8601DateFormatter.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 12/4/19.
//

import Foundation

extension ISO8601DateFormatter {

  /// A date formatter that parses dates like `2019-07-18T16:12:43.000Z`.
  static var youTube: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime]
    return formatter
  }()
}
