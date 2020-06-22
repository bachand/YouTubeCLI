//
//  Service.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import BachandNetworking
import Foundation

// MARK: - DefaultService

public final class DefaultService: Service {

  // MARK: Lifecycle

  public init(
    dataFetcher: DataFetcher = DefaultDataFetcher(urlSession: .shared),
    serialQueue: DispatchQueue = DispatchQueue(label: "com.bachand.defaultService"))
  {
    self.dataFetcher = dataFetcher
    decoder = JSONDecoder.makeForYouTube()
    self.serialQueue = serialQueue
  }

  // MARK: Public

  public enum ServiceError: Error {
    case noData
    case cannotDecode(decodingError: Error)
  }

  public func executeQuery(
    _ query: QueryProtocol,
    completionHandler: @escaping (QueryResult) -> Void)
  {
    getVideoIDs(query: query) { [weak self] (idsOfVideosResult) in
      let idsOfVideos: Array<String>
      do {
        idsOfVideos = try idsOfVideosResult.get()
      }
      catch {
        // TODO: Pass error one level up.
        print("Error fetching IDs: \(error)")
        let result = QueryResult(items: .init([]))
        completionHandler(result)
        return
      }
      self?.getVideos(apiKey: query.apiKey, idsOfVideos: idsOfVideos) { [weak self] videosResult in
        let videos: Array<VideoProtocol>
        do {
          videos = try videosResult.get()
        }
        catch {
          // TODO: Pass error one level up.
          print("Error fetching videos: \(error)")
          let items = idsOfVideos.map { QueryResult.Item.makePartial(with: $0) }
          let result = QueryResult(items: .init(items))
          completionHandler(result)
          return
        }
        var videosByID = Dictionary<String, VideoProtocol>()
        for video in videos {
          videosByID[video.id] = video
        }

        let items: [QueryResult.Item] = idsOfVideos.map { id in
          let video = videosByID[id]
          return QueryResult.Item(
            id: id,
            title: video?.title,
            imageURL: video.flatMap { self?.imageURL(from: $0) },
            publishDate: video.flatMap { self?.publishDate(from: $0) })
        }
        let result = QueryResult(items: .init(items))
        completionHandler(result)
      }
    }
  }

  // MARK: Private

  private let dataFetcher: DataFetcher
  private let decoder: JSONDecoder
  private let operationQueue = OperationQueue()
  private let serialQueue: DispatchQueue

  /// - parameter query: The query to make.
  /// - parameter completionHandler: Invoked on an arbitrary query when the IDs have been retrieved.
  private func getVideoIDs(
    query: QueryProtocol,
    completionHandler: @escaping (_ idsOfVideos: Result<Array<String>, Error>) -> Void)
  {
    serialQueue.async {
      let searchURLRequest = makeYouTubeSearchRequest(
        apiKey: query.apiKey,
        query: query.text,
        maxResults: 7,
        order: query.sort.toYouTubeSearchOrder())
      let operation = DataOperation(dataFetcher: self.dataFetcher, urlRequest: searchURLRequest)
      self.operationQueue.addOperation(operation)
      operation.waitUntilFinished()
      guard let data = operation.data else {
        completionHandler(.failure(ServiceError.noData))
        return
      }
      let searchListResponse: SearchListResponse
      do {
        searchListResponse = try self.decodeData(data, toType: SearchListResponse.self)
      }
      catch {
        completionHandler(.failure(ServiceError.cannotDecode(decodingError: error)))
        return
      }
      let idsOfVideos = searchListResponse.items.map { $0.id["videoId"] }.compactMap({ $0 })
      completionHandler(.success(idsOfVideos))
    }
  }

  /// - parameter apiKey: The API key to use to make the query.
  /// - parameter idsOfVideos: IDs of the videos to retreive.
  /// - parameter completionHandler: Invoked on an arbitrary query when the IDs have been retrieved.
  /// - parameter videos: The titles of the videos matching `idsOfVideos.
  private func getVideos(
    apiKey: String,
    idsOfVideos: Array<String>,
    completionHandler: @escaping (_ videos: Result<Array<VideoProtocol>, Error>) -> Void)
  {
    serialQueue.async {
      let searchURLRequest = makeYouTubeVideoListRequest(apiKey: apiKey, ids: idsOfVideos)
      let operation = DataOperation(dataFetcher: self.dataFetcher, urlRequest: searchURLRequest)
      self.operationQueue.addOperation(operation)
      operation.waitUntilFinished()
      guard let data = operation.data else {
        completionHandler(.failure(ServiceError.noData))
        return
      }
      let videoListResponse: VideoListResponse
      do {
        videoListResponse = try self.decodeData(data, toType: VideoListResponse.self)
      }
      catch {
        completionHandler(.failure(ServiceError.cannotDecode(decodingError: error)))
        return
      }
      completionHandler(.success(videoListResponse.videos))
    }
  }

  private func decodeData<T: Decodable>(_ data: Data, toType: T.Type) throws -> T {
    return try decoder.decode(T.self, from: data)
  }

  private func imageURL(from video: VideoProtocol) -> String? {
    video.highestResolutionImage?.absoluteString
  }

  private func publishDate(from video: VideoProtocol) -> String {
    let videoFormatter: (VideoProtocol) -> String = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
      dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
      return dateFormatter.string(from: $0.publishedAt) + " GMT"
    }
    return videoFormatter(video)
  }
}

// MARK: - Sort

extension Sort {

  fileprivate func toYouTubeSearchOrder() -> YouTubeSearchOrder {
    switch self {
    case .relevance: return .relevance
    case .newest: return .date
    }
  }
}
