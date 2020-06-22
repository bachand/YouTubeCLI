import ArgumentParser
import Foundation
import YouTubeCLIKit

// MARK: - Program

struct Program: ParsableCommand {

  enum Sort: String, ExpressibleByArgument {
    case relevance
    case newest
  }

  @Argument() var query: String

  @Option(default: .relevance, help: "The sort order of the results")
  var sort: Sort

  @Option(default: true, help: "Keeps lines 80 characters or less")
  var sizeToFit: Bool

  @Option(default: false, help: "Only print IDs")
  var idsOnly: Bool

  func run() {
    guard let key = ProcessInfo.processInfo.environment["YTC_KEY"] else { fatalError("No API key") }
    runProgram(apiKey: key, queryText: query)
  }

  private func runProgram(apiKey: String, queryText: String) {
    let dispatchGroup = DispatchGroup()

    dispatchGroup.enter()
    let service: Service = DefaultService()
    let query = Query(apiKey: apiKey, sort: sort.toQuerySort(), text: queryText)
    service.executeQuery(query) { result in
      self.printQueryResult(result)
      dispatchGroup.leave()
    }

    dispatchGroup.wait()
  }

  private func printQueryResult(_ queryResult: QueryResult) {
    let format: LineFormat
    // If the user wants IDs only, that takes precedence and "size to fit" is ignored. Ideally we
    // can define away this ambiguity.
    if idsOnly {
      format = .idsOnly
    }
    else {
      format = .full(sizeToFit: sizeToFit)
    }
    let output = queryResult.items.map { $0.toLine(format: format) }.joined(separator: "\n")
    print(output)
  }
}

// MARK: - LineFormat

enum LineFormat {
  /// Tries to display ID, title, and publish date—in that order. When `sizeToFit` is `true`, ensures that the line is <= 80
  /// characters.
  case full(sizeToFit: Bool)
  /// Only displays IDs.
  case idsOnly
}

// MARK: -  Program.Sort

extension Program.Sort {
  func toQuerySort() -> YouTubeCLIKit.Sort {
    switch self {
    case .newest: return .newest
    case .relevance: return .relevance
    }
  }
}

// MARK: - QueryResult.Item

extension QueryResult.Item {

  fileprivate func toLine(format: LineFormat) -> String {
    let fields: [String?]
    switch format {
    case let .full(sizeToFit):
      fields = [
        id,
        sizeToFit ? title?.fitToLength(60) : title,
        publishDate
      ]
    case .idsOnly:
      fields = [id]
    }
    return fields.compactMap { $0 }.joined(separator: " ")
  }
}

// MARK: - StringProtocol

extension StringProtocol {

  fileprivate func fitToLength(_ maxLength: Int) -> String {
    let fittedRange: Range<String.Index>
    if count > maxLength {
      fittedRange = startIndex..<index(startIndex, offsetBy: maxLength)
    }
    else {
      fittedRange = startIndex..<endIndex
    }
    return String(self[fittedRange])
  }
}

Program.main()
