//
//  ModelsTests.swift
//  YouTubeCLI
//
//  Created by Michael Bachand on 11/30/19.
//

import Foundation
import XCTest

@testable import YouTubeCLIKit

// MARK: - SearchListResponseTests

final class SearchListResponseTests: XCTestCase {

  // MARK: Internal

  override func setUp() {
    super.setUp()
    decoder = JSONDecoder.makeForYouTube()
  }

  override func tearDown() {
    super.tearDown()
    decoder = nil
  }

  func test_decoding() {
    let jsonAsData = searchListResponseString.data(using: .utf8)!
    let searchResponseList = try! decoder.decode(SearchListResponse.self, from: jsonAsData)
    guard searchResponseList.kind == "youtube#searchListResponse" else { fatalError() }
    guard searchResponseList.etag == "\"p4VTdlkQv3HQeTEaXgvLePAydmU/YNcAHFvt_Jx_-8EZhkQDzHqITrA\"" else { fatalError() }
    guard searchResponseList.nextPageToken == "CAUQAA" else { fatalError() }
    guard searchResponseList.prevPageToken == nil else { fatalError() }
    guard searchResponseList.regionCode == "US" else { fatalError() }
    guard searchResponseList.pageInfo == ["totalResults": 1000000, "resultsPerPage": 5] else { fatalError() }
    guard searchResponseList.items.count == 5 else { fatalError() }
  }

  // MARK: Private

  private var decoder: JSONDecoder!
}

// MARK: - SearchResultTests

final class SearchResultTests: XCTestCase {

  // MARK: Internal

  override func setUp() {
    super.setUp()
    decoder = JSONDecoder.makeForYouTube()
  }

  override func tearDown() {
    super.tearDown()
    decoder = nil
  }

  func test_decoding1() {
    let jsonAsData = searchResultString1.data(using: .utf8)!
    let searchResult = try! decoder.decode(SearchResult.self, from: jsonAsData)
    guard searchResult.kind == "youtube#searchResult" else { fatalError() }
    guard searchResult.etag == "\"p4VTdlkQv3HQeTEaXgvLePAydmU/X7IVbK05yNa6N9cBV-OBslnP3Ws\"" else { fatalError() }
    guard searchResult.id == ["kind": "youtube#video", "videoId": "3ymwOvzhwHs"] else { fatalError() }
    guard searchResult.title == "TWICE &quot;Feel Special&quot; M/V" else { fatalError() }
  }
  
  func test_decoding2() {
    let jsonAsData = searchResultString2.data(using: .utf8)!
    let searchResult = try! decoder.decode(SearchResult.self, from: jsonAsData)
    guard searchResult.kind == "youtube#searchResult" else { fatalError() }
    guard searchResult.etag == "\"p4VTdlkQv3HQeTEaXgvLePAydmU/RioraahwQ52jG-2lI8yJxQbpe38\"" else { fatalError() }
    guard searchResult.id == ["kind": "youtube#video", "videoId": "zAGVQLHvwOY"] else { fatalError() }
    guard searchResult.title == "JOKER - Final Trailer - Now Playing In Theaters" else { fatalError() }
  }

  func test_decoding3() {
    let jsonAsData = searchResultString3.data(using: .utf8)!
    let searchResult = try! decoder.decode(SearchResult.self, from: jsonAsData)
    guard searchResult.kind == "youtube#searchResult" else { fatalError() }
    guard searchResult.etag == "\"p4VTdlkQv3HQeTEaXgvLePAydmU/yrKm7s0lHJuHz-RtjlDCVGinoEk\"" else { fatalError() }
    guard searchResult.id == ["kind": "youtube#video", "videoId": "QntBkDFkiuY"] else { fatalError() }
    guard searchResult.title == "Will Smith Surprises Viral Video Classmates for Their Kindness" else { fatalError() }
  }

  // MARK: Private

  private var decoder: JSONDecoder!
}

// MARK: - VideoListResponseTests

final class VideoListResponseTests: XCTestCase {

  // MARK: Internal

  override func setUp() {
    super.setUp()
    decoder = JSONDecoder.makeForYouTube()
  }

  override func tearDown() {
    super.tearDown()
    decoder = nil
  }

  func test_decoding() {
    let jsonAsData = videoListResponseString.data(using: .utf8)!
    let videoListResponse = try! decoder.decode(VideoListResponse.self, from: jsonAsData)
    guard videoListResponse.kind == "youtube#videoListResponse" else { fatalError() }
    guard videoListResponse.etag == "\"j6xRRd8dTPVVptg711_CSPADRfg/Wki1OzdW5n5VpYpv__VBle5zBqY\"" else { fatalError() }
    guard videoListResponse.pageInfo.totalResults == 3 else { fatalError() }
    guard videoListResponse.pageInfo.resultsPerPage == 3 else { fatalError() }
  }

  // MARK: Private

  private var decoder: JSONDecoder!
}

// MARK: - VideoTests

final class VideoTests: XCTestCase {

  override func setUp() {
    super.setUp()
    decoder = JSONDecoder.makeForYouTube()
  }

  override func tearDown() {
    super.tearDown()
    decoder = nil
  }

  func test_decoding1() {
    let jsonAsData = videoString1.data(using: .utf8)!
    let video = try! decoder.decode(Video.self, from: jsonAsData)
    guard video.kind == "youtube#video" else { fatalError() }
    guard video.etag == "\"j6xRRd8dTPVVptg711_CSPADRfg/3wS8B_h8ctUbEB7_oALni_T-iwQ\"" else { fatalError() }
    guard video.id == "UAlIq7BKNxg" else { fatalError() }
    guard video.title == "Mine All Day (Minecraft Music Video)" else { fatalError() }
    guard video.tags == ["SATIRE"] else { fatalError() }

    let expectedImages: Set<String> = [
      "https://i.ytimg.com/vi/UAlIq7BKNxg/default.jpg",
      "https://i.ytimg.com/vi/UAlIq7BKNxg/mqdefault.jpg",
      "https://i.ytimg.com/vi/UAlIq7BKNxg/hqdefault.jpg",
      "https://i.ytimg.com/vi/UAlIq7BKNxg/sddefault.jpg",
      "https://i.ytimg.com/vi/UAlIq7BKNxg/maxresdefault.jpg",
    ]
    XCTAssertEqual(expectedImages, Set(video.images.map({ $0.absoluteString })))

    XCTAssertEqual(video.publishedAt, Date(timeIntervalSince1970: 1571851200))
  }

  func test_decoding2() {
    let jsonAsData = videoString2.data(using: .utf8)!
    let video = try! decoder.decode(Video.self, from: jsonAsData)
    guard video.kind == "youtube#video" else { fatalError() }
    guard video.etag == "\"j6xRRd8dTPVVptg711_CSPADRfg/1qJFjH3VUzkk6J-_3pETwX-RM-E\"" else { fatalError() }
    guard video.id == "CVSXenFcPoo" else { fatalError() }
    // TODO: Complete checks, if necessary.

    let expectedImages: Set<String> = [
      "https://i.ytimg.com/vi/CVSXenFcPoo/default.jpg",
      "https://i.ytimg.com/vi/CVSXenFcPoo/mqdefault.jpg",
      "https://i.ytimg.com/vi/CVSXenFcPoo/hqdefault.jpg",
      "https://i.ytimg.com/vi/CVSXenFcPoo/sddefault.jpg",
      "https://i.ytimg.com/vi/CVSXenFcPoo/maxresdefault.jpg",
    ]
    XCTAssertEqual(expectedImages, Set(video.images.map({ $0.absoluteString })))

    XCTAssertEqual(video.publishedAt, Date(timeIntervalSince1970: 1571725157))
  }

  func test_decoding3() {
    let jsonAsData = videoString3.data(using: .utf8)!
    let video = try! decoder.decode(Video.self, from: jsonAsData)
    guard video.kind == "youtube#video" else { fatalError() }
    guard video.etag == "\"j6xRRd8dTPVVptg711_CSPADRfg/Ah1AxOyLUdgNGvhJiG1Qi4HEuqE\"" else { fatalError() }
    guard video.id == "SZcUJuXjCsw" else { fatalError() }
    // TODO: Complete checks, if necessary.

    let expectedImages: Set<String> = [
      "https://i.ytimg.com/vi/SZcUJuXjCsw/default.jpg",
      "https://i.ytimg.com/vi/SZcUJuXjCsw/mqdefault.jpg",
      "https://i.ytimg.com/vi/SZcUJuXjCsw/hqdefault.jpg",
      "https://i.ytimg.com/vi/SZcUJuXjCsw/sddefault.jpg",
      "https://i.ytimg.com/vi/SZcUJuXjCsw/maxresdefault.jpg",
    ]
    XCTAssertEqual(expectedImages, Set(video.images.map({ $0.absoluteString })))

    XCTAssertEqual(video.publishedAt, Date(timeIntervalSince1970: 1572354005))
  }

  func test_decoding_noTags() throws {
    let jsonAsData = videoString_noTags.data(using: .utf8)!
    XCTAssertNoThrow(try decoder.decode(Video.self, from: jsonAsData))
  }

  func test_decoding_invalidThumbnailImageURL() throws {
    let jsonAsData = videoString_invalidThumbnailImageURL.data(using: .utf8)!
    XCTAssertThrowsError(
      try decoder.decode(Video.self, from: jsonAsData),
      "Should fail to decode an invalid URL")
    {
      XCTAssert($0 is Video.DecodingError)
    }
  }

  // MARK: Private

  private var decoder: JSONDecoder!
}

// MARK: - Search List Responses

public let searchResultString1 = """
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/X7IVbK05yNa6N9cBV-OBslnP3Ws\\"",
"id": {
"kind": "youtube#video",
"videoId": "3ymwOvzhwHs"
},
"snippet": {
"publishedAt": "2019-09-23T09:00:11Z",
"channelId": "UCaO6TYtlC8U5ttz62hTrZgg",
"title": "TWICE &quot;Feel Special&quot; M/V",
"description": "TWICE \\"Feel Special\\" M/V Spotify http://open.spotify.com/album/4EG4E0Uk0HpJBgOMgXI26z iTunes/Apple Music ...",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/3ymwOvzhwHs/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/3ymwOvzhwHs/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/3ymwOvzhwHs/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "jypentertainment",
"liveBroadcastContent": "none"
}
}
"""

public let searchResultString2 = """
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/RioraahwQ52jG-2lI8yJxQbpe38\\"",
"id": {
"kind": "youtube#video",
"videoId": "zAGVQLHvwOY"
},
"snippet": {
"publishedAt": "2019-08-28T15:59:43Z",
"channelId": "UCjmJDM5pRKbUlVIzDYYWb6g",
"title": "JOKER - Final Trailer - Now Playing In Theaters",
"description": "https://www.joker.movie https://www.facebook.com/jokermovie https://twitter.com/jokermovie https://www.instagram.com/jokermovie/ Director Todd Phillips ...",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/zAGVQLHvwOY/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/zAGVQLHvwOY/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/zAGVQLHvwOY/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "Warner Bros. Pictures",
"liveBroadcastContent": "none"
}
}
"""

public let searchResultString3 = """
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/yrKm7s0lHJuHz-RtjlDCVGinoEk\\"",
"id": {
"kind": "youtube#video",
"videoId": "QntBkDFkiuY"
},
"snippet": {
"publishedAt": "2019-09-20T21:00:03Z",
"channelId": "UCp0hYYBW6IMayGgR-WeoCvQ",
"title": "Will Smith Surprises Viral Video Classmates for Their Kindness",
"description": "Ellen welcomed high school students Kristopher and Antwain, who surprised their bullied classmate, Micheal, with new clothes and shoes. A video of the kind ...",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/QntBkDFkiuY/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/QntBkDFkiuY/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/QntBkDFkiuY/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "TheEllenShow",
"liveBroadcastContent": "none"
}
}
"""

// ## Documentation
//
//  {
//      "kind": "youtube#searchListResponse",
//      "etag": etag,
//      "nextPageToken": string,
//      "prevPageToken": string,
//      "regionCode": string,
//      "pageInfo": {
//          "totalResults": integer,
//          "resultsPerPage": integer
//      },
//      "items": [
//      search Resource
//      ]
//  }


public let searchListResponseString = """
{
"kind": "youtube#searchListResponse",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/YNcAHFvt_Jx_-8EZhkQDzHqITrA\\"",
"nextPageToken": "CAUQAA",
"regionCode": "US",
"pageInfo": {
"totalResults": 1000000,
"resultsPerPage": 5
},
"items": [
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/X7IVbK05yNa6N9cBV-OBslnP3Ws\\"",
"id": {
"kind": "youtube#video",
"videoId": "3ymwOvzhwHs"
},
"snippet": {
"publishedAt": "2019-09-23T09:00:11Z",
"channelId": "UCaO6TYtlC8U5ttz62hTrZgg",
"title": "TWICE &quot;Feel Special&quot; M/V",
"description": "TWICE \\"Feel Special\\" M/V Spotify http://open.spotify.com/album/4EG4E0Uk0HpJBgOMgXI26z iTunes/Apple Music ...",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/3ymwOvzhwHs/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/3ymwOvzhwHs/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/3ymwOvzhwHs/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "jypentertainment",
"liveBroadcastContent": "none"
}
},
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/RioraahwQ52jG-2lI8yJxQbpe38\\"",
"id": {
"kind": "youtube#video",
"videoId": "zAGVQLHvwOY"
},
"snippet": {
"publishedAt": "2019-08-28T15:59:43Z",
"channelId": "UCjmJDM5pRKbUlVIzDYYWb6g",
"title": "JOKER - Final Trailer - Now Playing In Theaters",
"description": "https://www.joker.movie https://www.facebook.com/jokermovie https://twitter.com/jokermovie https://www.instagram.com/jokermovie/ Director Todd Phillips ...",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/zAGVQLHvwOY/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/zAGVQLHvwOY/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/zAGVQLHvwOY/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "Warner Bros. Pictures",
"liveBroadcastContent": "none"
}
},
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/yrKm7s0lHJuHz-RtjlDCVGinoEk\\"",
"id": {
"kind": "youtube#video",
"videoId": "QntBkDFkiuY"
},
"snippet": {
"publishedAt": "2019-09-20T21:00:03Z",
"channelId": "UCp0hYYBW6IMayGgR-WeoCvQ",
"title": "Will Smith Surprises Viral Video Classmates for Their Kindness",
"description": "Ellen welcomed high school students Kristopher and Antwain, who surprised their bullied classmate, Micheal, with new clothes and shoes. A video of the kind ...",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/QntBkDFkiuY/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/QntBkDFkiuY/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/QntBkDFkiuY/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "TheEllenShow",
"liveBroadcastContent": "none"
}
},
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/0kOj36CP_A_SVpQNhV-FoKa8yW8\\"",
"id": {
"kind": "youtube#video",
"videoId": "FHYtj1m_5QI"
},
"snippet": {
"publishedAt": "2018-05-19T13:00:00Z",
"channelId": "UCp0hYYBW6IMayGgR-WeoCvQ",
"title": "Ellen Shocks Jeannie With a Huge Surprise",
"description": "It's been 10 years since Ellen gave Jeannie her first-ever job, and to celebrate the milestone, Ellen shocked Jeannie with an unforgettable surprise.",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/FHYtj1m_5QI/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/FHYtj1m_5QI/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/FHYtj1m_5QI/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "TheEllenShow",
"liveBroadcastContent": "none"
}
},
{
"kind": "youtube#searchResult",
"etag": "\\"p4VTdlkQv3HQeTEaXgvLePAydmU/vMauRp7ZK_Zdx93Xv6KiglTSgj4\\"",
"id": {
"kind": "youtube#video",
"videoId": "29a6o5vRKVM"
},
"snippet": {
"publishedAt": "2019-07-18T16:12:43Z",
"channelId": "UCEdvpU2pFRCVqU6yIPyTpMQ",
"title": "Marshmello &amp; Kane Brown - One Thing Right (Official Music Video)",
"description": "Marshmello & Kane Brown - One Thing Right (Official Music Video) Download / Stream 'One Thing Right' ▷ https://smarturl.it/melloxkb Shop The Official 'One ...",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/29a6o5vRKVM/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/29a6o5vRKVM/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/29a6o5vRKVM/hqdefault.jpg",
"width": 480,
"height": 360
}
},
"channelTitle": "Marshmello",
"liveBroadcastContent": "none"
}
}
]
}
"""

// MARK: - Video List Responses


public let videoString1 = """
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/3wS8B_h8ctUbEB7_oALni_T-iwQ\\"",
"id": "UAlIq7BKNxg",
"snippet": {
"publishedAt": "2019-10-23T17:20:00Z",
"channelId": "UC-lHJZR3Gqxm24_Vd_AJ5Yw",
"title": "Mine All Day (Minecraft Music Video)",
"description": "► Spotify/Itunes: http://smarturl.it/mineallday\\n\\nMusic by: Party In Backyard\\nhttps://www.youtube.com/partyinbackyard\\n\\nLyrics by: David Paul Brown (boyinaband):\\nhttps://www.youtube.com/boyinaband\\nPewdiepie (Pewdiepie):\\nhttps://www.youtube.com/pewpewpewpewDIE\\n\\nAnimation by: AndyBTTF:\\nhttps://www.youtube.com/andybttf\\n(Additional animation by Achebe Spencer, Mahmood Noor, \\nMalakai Breckenridge, Gabriel Carmo, Gabriel Rocha, and Preston Guruith)\\n\\nVideo Edit by: Dylan Locke\\nhttps://www.youtube.com/dylanlocke\\n\\nFilmed by: PJ (KickThePj)\\nhttps://www.youtube.com/KickThePj\\n\\n► Instrumental: https://youtu.be/vYOF-3A4ZtM\\n► Acapella: https://youtu.be/BFff6eNcTwc",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/hqdefault.jpg",
"width": 480,
"height": 360
},
"standard": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/sddefault.jpg",
"width": 640,
"height": 480
},
"maxres": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/maxresdefault.jpg",
"width": 1280,
"height": 720
}
},
"channelTitle": "PewDiePie",
"tags": [
"SATIRE"
],
"categoryId": "24",
"liveBroadcastContent": "none",
"localized": {
"title": "Mine All Day (Minecraft Music Video)",
"description": "► Spotify/Itunes: http://smarturl.it/mineallday\\n\\nMusic by: Party In Backyard\\nhttps://www.youtube.com/partyinbackyard\\n\\nLyrics by: David Paul Brown (boyinaband):\\nhttps://www.youtube.com/boyinaband\\nPewdiepie (Pewdiepie):\\nhttps://www.youtube.com/pewpewpewpewDIE\\n\\nAnimation by: AndyBTTF:\\nhttps://www.youtube.com/andybttf\\n(Additional animation by Achebe Spencer, Mahmood Noor, \\nMalakai Breckenridge, Gabriel Carmo, Gabriel Rocha, and Preston Guruith)\\n\\nVideo Edit by: Dylan Locke\\nhttps://www.youtube.com/dylanlocke\\n\\nFilmed by: PJ (KickThePj)\\nhttps://www.youtube.com/KickThePj\\n\\n► Instrumental: https://youtu.be/vYOF-3A4ZtM\\n► Acapella: https://youtu.be/BFff6eNcTwc"
}
}
}
"""

public let videoString2 = """
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/1qJFjH3VUzkk6J-_3pETwX-RM-E\\"",
"id": "CVSXenFcPoo",
"snippet": {
"publishedAt": "2019-10-22T06:19:17Z",
"channelId": "UCaXkIU1QidjPwiAYu6GcHjg",
"title": "Lawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC",
"description": "In a weekend tweet, President Trump misnamed his Secretary of Defense. Lawrence O’Donnell talks with Norm Ornstein and Matt Miller about why this is a grave mistake for Trump and his staff. Aired on 10/21/19.\\n» Subscribe to MSNBC: http://on.msnbc.com/SubscribeTomsnbc\\n\\nMSNBC delivers breaking news, in-depth analysis of politics headlines, as well as commentary and informed perspectives. Find video clips and segments from The Rachel Maddow Show, Morning Joe, Meet the Press Daily, The Beat with Ari Melber, Deadline: White House with Nicolle Wallace, Hardball, All In, Last Word, 11th Hour, and more.\\n\\nConnect with MSNBC Online\\nVisit msnbc.com: http://on.msnbc.com/Readmsnbc\\nSubscribe to MSNBC Newsletter: http://MSNBC.com/NewslettersYouTube\\nFind MSNBC on Facebook: http://on.msnbc.com/Likemsnbc\\nFollow MSNBC on Twitter: http://on.msnbc.com/Followmsnbc\\nFollow MSNBC on Instagram: http://on.msnbc.com/Instamsnbc\\n\\nLawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/hqdefault.jpg",
"width": 480,
"height": 360
},
"standard": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/sddefault.jpg",
"width": 640,
"height": 480
},
"maxres": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/maxresdefault.jpg",
"width": 1280,
"height": 720
}
},
"channelTitle": "MSNBC",
"tags": [
"White House",
"Donald Trump",
"Defense",
"The Last Word with Lawrence O'Donnell",
"Last Word",
"The Last Word",
"Lawrence O'Donnell",
"MSNBC",
"MSNBC News",
"MSNBC Live",
"US News",
"Current Events",
"Progressive News",
"Liberal News",
"lawrence odonnell",
"lawrence odonnell live",
"news",
"Mark Esperanto",
"Secretary of Defense",
"Norm Ornstein",
"Matt Miller",
"Trump",
"President Trump",
"white house staff",
"white house security",
"mueller investigation",
"weekend tweet",
"trump tweets",
"american defense",
"us soldier"
],
"categoryId": "25",
"liveBroadcastContent": "none",
"localized": {
"title": "Lawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC",
"description": "In a weekend tweet, President Trump misnamed his Secretary of Defense. Lawrence O’Donnell talks with Norm Ornstein and Matt Miller about why this is a grave mistake for Trump and his staff. Aired on 10/21/19.\\n» Subscribe to MSNBC: http://on.msnbc.com/SubscribeTomsnbc\\n\\nMSNBC delivers breaking news, in-depth analysis of politics headlines, as well as commentary and informed perspectives. Find video clips and segments from The Rachel Maddow Show, Morning Joe, Meet the Press Daily, The Beat with Ari Melber, Deadline: White House with Nicolle Wallace, Hardball, All In, Last Word, 11th Hour, and more.\\n\\nConnect with MSNBC Online\\nVisit msnbc.com: http://on.msnbc.com/Readmsnbc\\nSubscribe to MSNBC Newsletter: http://MSNBC.com/NewslettersYouTube\\nFind MSNBC on Facebook: http://on.msnbc.com/Likemsnbc\\nFollow MSNBC on Twitter: http://on.msnbc.com/Followmsnbc\\nFollow MSNBC on Instagram: http://on.msnbc.com/Instamsnbc\\n\\nLawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC"
},
"defaultAudioLanguage": "en"
},
"recordingDetails": {
"location": {
"latitude": 0.0,
"longitude": 0.0,
"altitude": 0.0
}
}
}
"""

public let videoString3 = """
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/Ah1AxOyLUdgNGvhJiG1Qi4HEuqE\\"",
"id": "SZcUJuXjCsw",
"snippet": {
"publishedAt": "2019-10-29T13:00:05Z",
"channelId": "UCJHA_jMfCvEnv-3kRjTCQXw",
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/hqdefault.jpg",
"width": 480,
"height": 360
},
"standard": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/sddefault.jpg",
"width": 640,
"height": 480
},
"maxres": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/maxresdefault.jpg",
"width": 1280,
"height": 720
}
},
"channelTitle": "Binging with Babish",
"tags": [
"glazed pork chops",
"pork chops",
"bone in pork chops",
"pork chop",
"pork chop recipes",
"how to make pork chops",
"glazed pork chops recipe",
"apex",
"legends",
"apex legends",
"mirage",
"mirage pork chops",
"mirages pork chops",
"dinner recipes",
"glaze",
"pan sauce",
"sweet and sour pork",
"how to cook pork",
"sous vide",
"binging with babish",
"babbish",
"cooking with babish",
"pear qwerty horse",
"apex legends pork chops",
"pork chops apex legends"
],
"categoryId": "24",
"liveBroadcastContent": "none",
"localized": {
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter"
},
"defaultAudioLanguage": "en"
}
}
"""

public let videoString_noTags = """
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/Ah1AxOyLUdgNGvhJiG1Qi4HEuqE\\"",
"id": "SZcUJuXjCsw",
"snippet": {
"publishedAt": "2019-10-29T13:00:05Z",
"channelId": "UCJHA_jMfCvEnv-3kRjTCQXw",
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/hqdefault.jpg",
"width": 480,
"height": 360
},
"standard": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/sddefault.jpg",
"width": 640,
"height": 480
},
"maxres": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/maxresdefault.jpg",
"width": 1280,
"height": 720
}
},
"channelTitle": "Binging with Babish",
"categoryId": "24",
"liveBroadcastContent": "none",
"localized": {
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter"
},
"defaultAudioLanguage": "en"
}
}
"""

public let videoString_invalidThumbnailImageURL = """
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/Ah1AxOyLUdgNGvhJiG1Qi4HEuqE\\"",
"id": "SZcUJuXjCsw",
"snippet": {
"publishedAt": "2019-10-29T13:00:05Z",
"channelId": "UCJHA_jMfCvEnv-3kRjTCQXw",
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter",
"thumbnails": {
"default": {
"url": "",
"width": 120,
"height": 90
},
},
"channelTitle": "Binging with Babish",
"categoryId": "24",
"liveBroadcastContent": "none",
"localized": {
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter"
},
"defaultAudioLanguage": "en"
}
}
"""

let videoListResponseString = """
{
"kind": "youtube#videoListResponse",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/Wki1OzdW5n5VpYpv__VBle5zBqY\\"",
"pageInfo": {
"totalResults": 3,
"resultsPerPage": 3
},
"items": [
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/3wS8B_h8ctUbEB7_oALni_T-iwQ\\"",
"id": "UAlIq7BKNxg",
"snippet": {
"publishedAt": "2019-10-23T17:20:14Z",
"channelId": "UC-lHJZR3Gqxm24_Vd_AJ5Yw",
"title": "Mine All Day (Minecraft Music Video)",
"description": "► Spotify/Itunes: http://smarturl.it/mineallday\\n\\nMusic by: Party In Backyard\\nhttps://www.youtube.com/partyinbackyard\\n\\nLyrics by: David Paul Brown (boyinaband):\\nhttps://www.youtube.com/boyinaband\\nPewdiepie (Pewdiepie):\\nhttps://www.youtube.com/pewpewpewpewDIE\\n\\nAnimation by: AndyBTTF:\\nhttps://www.youtube.com/andybttf\\n(Additional animation by Achebe Spencer, Mahmood Noor, \\nMalakai Breckenridge, Gabriel Carmo, Gabriel Rocha, and Preston Guruith)\\n\\nVideo Edit by: Dylan Locke\\nhttps://www.youtube.com/dylanlocke\\n\\nFilmed by: PJ (KickThePj)\\nhttps://www.youtube.com/KickThePj\\n\\n► Instrumental: https://youtu.be/vYOF-3A4ZtM\\n► Acapella: https://youtu.be/BFff6eNcTwc",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/hqdefault.jpg",
"width": 480,
"height": 360
},
"standard": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/sddefault.jpg",
"width": 640,
"height": 480
},
"maxres": {
"url": "https://i.ytimg.com/vi/UAlIq7BKNxg/maxresdefault.jpg",
"width": 1280,
"height": 720
}
},
"channelTitle": "PewDiePie",
"tags": [
"SATIRE"
],
"categoryId": "24",
"liveBroadcastContent": "none",
"localized": {
"title": "Mine All Day (Minecraft Music Video)",
"description": "► Spotify/Itunes: http://smarturl.it/mineallday\\n\\nMusic by: Party In Backyard\\nhttps://www.youtube.com/partyinbackyard\\n\\nLyrics by: David Paul Brown (boyinaband):\\nhttps://www.youtube.com/boyinaband\\nPewdiepie (Pewdiepie):\\nhttps://www.youtube.com/pewpewpewpewDIE\\n\\nAnimation by: AndyBTTF:\\nhttps://www.youtube.com/andybttf\\n(Additional animation by Achebe Spencer, Mahmood Noor, \\nMalakai Breckenridge, Gabriel Carmo, Gabriel Rocha, and Preston Guruith)\\n\\nVideo Edit by: Dylan Locke\\nhttps://www.youtube.com/dylanlocke\\n\\nFilmed by: PJ (KickThePj)\\nhttps://www.youtube.com/KickThePj\\n\\n► Instrumental: https://youtu.be/vYOF-3A4ZtM\\n► Acapella: https://youtu.be/BFff6eNcTwc"
}
}
},
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/1qJFjH3VUzkk6J-_3pETwX-RM-E\\"",
"id": "CVSXenFcPoo",
"snippet": {
"publishedAt": "2019-10-22T06:19:17Z",
"channelId": "UCaXkIU1QidjPwiAYu6GcHjg",
"title": "Lawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC",
"description": "In a weekend tweet, President Trump misnamed his Secretary of Defense. Lawrence O’Donnell talks with Norm Ornstein and Matt Miller about why this is a grave mistake for Trump and his staff. Aired on 10/21/19.\\n» Subscribe to MSNBC: http://on.msnbc.com/SubscribeTomsnbc\\n\\nMSNBC delivers breaking news, in-depth analysis of politics headlines, as well as commentary and informed perspectives. Find video clips and segments from The Rachel Maddow Show, Morning Joe, Meet the Press Daily, The Beat with Ari Melber, Deadline: White House with Nicolle Wallace, Hardball, All In, Last Word, 11th Hour, and more.\\n\\nConnect with MSNBC Online\\nVisit msnbc.com: http://on.msnbc.com/Readmsnbc\\nSubscribe to MSNBC Newsletter: http://MSNBC.com/NewslettersYouTube\\nFind MSNBC on Facebook: http://on.msnbc.com/Likemsnbc\\nFollow MSNBC on Twitter: http://on.msnbc.com/Followmsnbc\\nFollow MSNBC on Instagram: http://on.msnbc.com/Instamsnbc\\n\\nLawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/hqdefault.jpg",
"width": 480,
"height": 360
},
"standard": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/sddefault.jpg",
"width": 640,
"height": 480
},
"maxres": {
"url": "https://i.ytimg.com/vi/CVSXenFcPoo/maxresdefault.jpg",
"width": 1280,
"height": 720
}
},
"channelTitle": "MSNBC",
"tags": [
"White House",
"Donald Trump",
"Defense",
"The Last Word with Lawrence O'Donnell",
"Last Word",
"The Last Word",
"Lawrence O'Donnell",
"MSNBC",
"MSNBC News",
"MSNBC Live",
"US News",
"Current Events",
"Progressive News",
"Liberal News",
"lawrence odonnell",
"lawrence odonnell live",
"news",
"Mark Esperanto",
"Secretary of Defense",
"Norm Ornstein",
"Matt Miller",
"Trump",
"President Trump",
"white house staff",
"white house security",
"mueller investigation",
"weekend tweet",
"trump tweets",
"american defense",
"us soldier"
],
"categoryId": "25",
"liveBroadcastContent": "none",
"localized": {
"title": "Lawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC",
"description": "In a weekend tweet, President Trump misnamed his Secretary of Defense. Lawrence O’Donnell talks with Norm Ornstein and Matt Miller about why this is a grave mistake for Trump and his staff. Aired on 10/21/19.\\n» Subscribe to MSNBC: http://on.msnbc.com/SubscribeTomsnbc\\n\\nMSNBC delivers breaking news, in-depth analysis of politics headlines, as well as commentary and informed perspectives. Find video clips and segments from The Rachel Maddow Show, Morning Joe, Meet the Press Daily, The Beat with Ari Melber, Deadline: White House with Nicolle Wallace, Hardball, All In, Last Word, 11th Hour, and more.\\n\\nConnect with MSNBC Online\\nVisit msnbc.com: http://on.msnbc.com/Readmsnbc\\nSubscribe to MSNBC Newsletter: http://MSNBC.com/NewslettersYouTube\\nFind MSNBC on Facebook: http://on.msnbc.com/Likemsnbc\\nFollow MSNBC on Twitter: http://on.msnbc.com/Followmsnbc\\nFollow MSNBC on Instagram: http://on.msnbc.com/Instamsnbc\\n\\nLawrence On ‘The Clear And Present Danger Of Mark Esperanto’ | The Last Word | MSNBC"
},
"defaultAudioLanguage": "en"
},
"recordingDetails": {
"location": {
"latitude": 0.0,
"longitude": 0.0,
"altitude": 0.0
}
}
},
{
"kind": "youtube#video",
"etag": "\\"j6xRRd8dTPVVptg711_CSPADRfg/Ah1AxOyLUdgNGvhJiG1Qi4HEuqE\\"",
"id": "SZcUJuXjCsw",
"snippet": {
"publishedAt": "2019-10-29T13:00:05Z",
"channelId": "UCJHA_jMfCvEnv-3kRjTCQXw",
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter",
"thumbnails": {
"default": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/default.jpg",
"width": 120,
"height": 90
},
"medium": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/mqdefault.jpg",
"width": 320,
"height": 180
},
"high": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/hqdefault.jpg",
"width": 480,
"height": 360
},
"standard": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/sddefault.jpg",
"width": 640,
"height": 480
},
"maxres": {
"url": "https://i.ytimg.com/vi/SZcUJuXjCsw/maxresdefault.jpg",
"width": 1280,
"height": 720
}
},
"channelTitle": "Binging with Babish",
"tags": [
"glazed pork chops",
"pork chops",
"bone in pork chops",
"pork chop",
"pork chop recipes",
"how to make pork chops",
"glazed pork chops recipe",
"apex",
"legends",
"apex legends",
"mirage",
"mirage pork chops",
"mirages pork chops",
"dinner recipes",
"glaze",
"pan sauce",
"sweet and sour pork",
"how to cook pork",
"sous vide",
"binging with babish",
"babbish",
"cooking with babish",
"pear qwerty horse",
"apex legends pork chops",
"pork chops apex legends"
],
"categoryId": "24",
"liveBroadcastContent": "none",
"localized": {
"title": "Binging with Babish: Glazed Pork Chops from Apex Legends",
"description": "The Binging with Babish Cookbook on sale now!\\nhttps://www.bingingwithbabish.com/cookbook\\n\\nCurrently on my book tour, tickets are still available in some cities!\\nhttps://www.bingingwithbabish.com/events\\n\\nThis week, we're exploring a hotly-requested video game easter egg: Mirage's beloved glazed pork chops from Apex Legends.  Sneakily included in one of the game's loading screens, this recipe goes from awful to wonderful to downright delectable...but difficult to look at.  Don't understand what I mean?  Watch the video ya big silly!\\n\\nMusic: \\"A Beautiful Life\\" by Broke for Free\\nhttps://soundcloud.com/broke-for-free\\n\\nMy new show, Being with Babish!\\nhttps://bit.ly/2R5IgTX\\n\\nMy playlist of preferred cooking tunes, Bangers with Babish! \\nhttps://spoti.fi/2TYXmiY\\n\\nBinging With Babish Website: http://bit.ly/BingingBabishWebsite\\nBasics With Babish Website: http://bit.ly/BasicsWithBabishWebsite\\nPatreon: http://bit.ly/BingingPatreon\\nInstagram: http://bit.ly/BabishInstagram\\nFacebook: http://bit.ly/BabishFacebook\\nTwitter: http://bit.ly/BabishTwitter"
},
"defaultAudioLanguage": "en"
}
}
]
}
"""
