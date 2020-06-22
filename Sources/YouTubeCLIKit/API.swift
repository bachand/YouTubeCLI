//
//  API.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import BachandNetworking
import Foundation

let basePath = "www.googleapis.com/youtube/v3"

/// Specifies the algorithm that will be used to order resources in the API response.
enum YouTubeSearchOrder: String {
  /// Resources are sorted in reverse chronological order based on the date they were created.
  case date
  /// Resources are sorted from highest to lowest rating.
  case rating
  /// Resources are sorted based on their relevance to the search query.
  case relevance
  /// Resources are sorted alphabetically by title.
  case title
  /// Channels are sorted in descending order of their number of uploaded videos.
  case videoCount
  /// Resources are sorted from highest to lowest number of views. For live broadcasts, videos are sorted by number of concurrent
  /// viewers while the broadcasts are ongoing.
  case viewCount
}

/// Makes a request to the YouTube API to search for videos.
///
/// The order of parameters in the URL is not defined.
///
/// - parameter apiKey: The key used to authenticate the request.
/// - parameter query: The string for which to search.
/// - parameter maxResults: The maximum number of results to return. Any number larger than 50 will be truncated to 50 per the
///   API specification.
/// - parameter order: Specifies the algorithm that will be used to order resources in the API response.
/// - parameter pageToken: A token from a previous API request that identifies a specific page in the result set that should be
///   returned.
func makeYouTubeSearchRequest(
  apiKey: String,
  query: String? = nil,
  maxResults: UInt? = nil,
  order: YouTubeSearchOrder? = nil,
  pageToken: String? = nil) -> URLRequest
{
  var urlComponents = URLComponents(string: "//\(basePath)/search")!
  urlComponents.scheme = "https"
  var queryItems = [
    URLQueryItem(name: "part", value: "snippet"),
    URLQueryItem(name: "key", value: apiKey),
  ]
  if let query = query {
    queryItems.append(URLQueryItem(name: "q", value: query))
  }
  if var maxResults = maxResults {
    if maxResults > 50 { maxResults = 50 }
    queryItems.append(URLQueryItem(name: "maxResults", value: String(maxResults)))
  }
  if let order = order {
    queryItems.append(URLQueryItem(name: "order", value: order.rawValue))
  }
  if let pageToken = pageToken {
    queryItems.append(URLQueryItem(name: "pageToken", value: pageToken))
  }
  urlComponents.appendQueryItems(queryItems)
  let url = urlComponents.url!
  return makeURLRequest(url)
}

/// Makes a request to the YouTube API to get a list of videos.
///
/// - parameter apiKey: The key used to authenticate the request.
/// - parameter ids: Identifiers of specific videos ot return.
func makeYouTubeVideoListRequest(apiKey: String, ids: Array<String>) -> URLRequest {
  var urlComponents = URLComponents(string: "//\(basePath)/videos")!
  urlComponents.scheme = "https"
  let queryItems = [
    URLQueryItem(name: "part", value: "snippet,recordingDetails"),
    URLQueryItem(name: "key", value: apiKey),
    URLQueryItem(name: "id", value: ids.joined(separator: ",")),
  ]
  urlComponents.queryItems = queryItems
  let url = urlComponents.url!
  return makeURLRequest(url)
}
