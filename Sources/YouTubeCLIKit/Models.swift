//
//  Models.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import Foundation

// MARK: - SearchResult

public struct SearchResult: Decodable {

  public let kind: String
  public let etag: String
  public let id: Dictionary<String, String>
  public let title: String

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.kind = try container.decode(String.self, forKey: .kind)
    self.etag = try container.decode(String.self, forKey: .etag)
    self.id = try container.decode(Dictionary<String, String>.self, forKey: .id)

    let snippet = try container.decode(Snippet.self, forKey: .snippet)
    self.title = snippet.title
  }

  private final class Snippet: Decodable {
    let title: String

    enum CodingKeys: String, CodingKey {
      case title
    }
  }

  private enum CodingKeys: String, CodingKey {
    case kind
    case etag
    case id
    case snippet
  }
}

// MARK: - SearchListResponse

public struct SearchListResponse: Decodable {
  public let kind: String
  public let etag: String
  public let nextPageToken: String
  public let prevPageToken: String?
  public let regionCode: String
  public let pageInfo: Dictionary<String, Int>
  public let items: Array<SearchResult>

  private enum CodingKeys: String, CodingKey {
    case kind
    case etag
    case nextPageToken
    case prevPageToken
    case regionCode
    case pageInfo
    case items
  }
}

// MARK: - Video

public struct Video: Decodable {
  public let kind: String
  public let etag: String
  public let id: String
  public let title: String
  public let tags: Array<String>?

  /// The default thumbnail image. The default thumbnail for a video – or a resource that refers to a video, such as a playlist item or search result – is 120px wide and 90px tall. The default thumbnail for a channel is 88px wide and 88px tall.
  public let imageDefault: URL?
  /// A higher resolution version of the thumbnail image. For a video (or a resource that refers to a video), this image is 320px wide and 180px tall. For a channel, this image is 240px wide and 240px tall.
  public let imageMedium: URL?
  /// A high resolution version of the thumbnail image. For a video (or a resource that refers to a video), this image is 480px wide and 360px tall. For a channel, this image is 800px wide and 800px tall.
  public let imageHigh: URL?
  /// An even higher resolution version of the thumbnail image than the `imageHigh` resolution image. This image is available for some videos and other resources that refer to videos, like playlist items or search results. This image is 640px wide and 480px tall.
  public let imageStandard: URL?
  /// The highest resolution version of the thumbnail image. This image size is available for some videos and other resources that refer to videos, like playlist items or search results. This image is 1280px wide and 720px tall.
  public let imageMaxRes: URL?

  /// The time at which this video was published. See YouTube documentation for details about edge cases (e.g. videos uploaded to a
  /// private channel before being published publicly).
  public let publishedAt: Date

  /// Useful for creating test doubles.
  public init(
    kind: String,
    etag: String,
    id: String,
    title: String,
    tags: Array<String>?,
    imageDefault: URL?,
    imageMedium: URL?,
    imageHigh: URL?,
    imageStandard: URL?,
    imageMaxRes: URL?,
    publishedAt: Date)
  {
    self.kind = kind
    self.etag = etag
    self.id = id
    self.title = title
    self.tags = tags
    self.imageDefault = imageDefault
    self.imageMedium = imageMedium
    self.imageHigh = imageHigh
    self.imageStandard = imageStandard
    self.imageMaxRes = imageMaxRes
    self.publishedAt = publishedAt
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.kind = try container.decode(String.self, forKey: .kind)
    self.etag = try container.decode(String.self, forKey: .etag)
    self.id = try container.decode(String.self, forKey: .id)

    let snippet = try container.decode(Snippet.self, forKey: .snippet)
    self.title = snippet.title
    self.tags = snippet.tags

    func image(from thumbnail: Snippet.Thumbnails.Thumbnail?) throws -> URL? {
      guard let thumbnail = thumbnail else { return nil }
      guard let image = URL(string: thumbnail.urlText) else {
        throw DecodingError.invalidURL
      }
      return image
    }

    imageDefault = try image(from: snippet.thumbnails.default)
    imageMedium = try image(from: snippet.thumbnails.medium)
    imageHigh = try image(from: snippet.thumbnails.high)
    imageStandard = try image(from: snippet.thumbnails.standard)
    imageMaxRes = try image(from: snippet.thumbnails.maxRes)

    publishedAt = snippet.publishedAt
  }

  private final class Snippet: Decodable {
    let title: String
    let tags: Array<String>?
    let thumbnails: Thumbnails
    let publishedAt: Date

    enum CodingKeys: String, CodingKey {
      case title
      case tags
      case thumbnails
      case publishedAt
    }

    final class Thumbnails: Decodable {

      let `default`: Thumbnail?
      let medium: Thumbnail?
      let high: Thumbnail?
      let standard: Thumbnail?
      let maxRes: Thumbnail?

      enum CodingKeys: String, CodingKey {
        case `default`
        case medium
        case high
        case standard
        case maxRes = "maxres"
      }

       class Thumbnail: Decodable {
         let height: Int
         let urlText: String
         let width: Int

         enum CodingKeys: String, CodingKey {
           case height
           case urlText = "url"
           case width
         }
       }
     }
  }

  private enum CodingKeys: String, CodingKey {
    case kind
    case etag
    case id
    case snippet
  }
}

// MARK: - Video.DecodingError

extension Video {
  public enum DecodingError: Error {
    case invalidURL
  }
}

// MARK: - VideoListResponse

public struct VideoListResponse: Decodable {
  public let kind: String
  public let etag: String
  public let pageInfo: PageInfo
  public let videos: Array<Video>

  private enum CodingKeys: String, CodingKey {
    case kind
    case etag
    case pageInfo
    case videos = "items"
  }

  public final class PageInfo: Decodable {
    public let totalResults: Int
    public let resultsPerPage: Int

    enum CodingKeys: String, CodingKey {
      case totalResults
      case resultsPerPage
    }
  }
}
