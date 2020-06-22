import XCTest
import class Foundation.Bundle

final class YouTubeCLITests: XCTestCase {

  func test_noArgs_printsUsage() throws {
    let (result, _) = try executeBinary(arguments: [])

    let stdOut = result.stdOut
    let data = stdOut.fileHandleForReading.readDataToEndOfFile()

    XCTAssertTrue(data.isEmpty)

    let stdErr = result.stdErr
    let errorData = stdErr.fileHandleForReading.readDataToEndOfFile()

    XCTAssertNotNil(errorData)
    let errorOutput = String(data: errorData, encoding: .utf8)

    XCTAssertEqual(errorOutput, """
    Error: Missing expected argument \'<query>\'
    Usage: program <query> [--sort <sort>] [--size-to-fit <size-to-fit>] [--ids-only <ids-only>]

    """)
  }

  func test_noArgs_exitsWithErrorStatus() throws {
    let (_, terminationStatus) = try executeBinary(arguments: [])
    XCTAssertNotEqual(terminationStatus, 0)
  }

  /// Returns path to the built products directory.
  var productsDirectory: URL {
    #if os(macOS)
    for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
      return bundle.bundleURL.deletingLastPathComponent()
    }
    fatalError("couldn't find the products directory")
    #else
    return Bundle.main.bundleURL
    #endif
  }

  static var allTests = [
    ("test_noArgs_printsUsage", test_noArgs_printsUsage),
    ("test_noArgs_exitsWithErrorStatus", test_noArgs_exitsWithErrorStatus),
  ]

  // MARK: Private

  private struct ExecuteBinaryResult {
    let stdOut: PipeProtocol
    let stdErr: PipeProtocol
  }

  /// - Returns: A tuple containing  a refrence to standard out and the termination status of the process.
  private func executeBinary(
    arguments: [String],
    standardInput: PipeProtocol? = nil) throws -> (ExecuteBinaryResult, Int32)
  {
    let fooBinary = productsDirectory.appendingPathComponent("YouTubeCLI")

    let process = Process()
    process.arguments = arguments
    process.executableURL = fooBinary
    process.standardInput = standardInput

    let stdOut = Pipe()
    process.standardOutput = stdOut

    let stdErr = Pipe()
    process.standardError = stdErr

    try process.run()
    process.waitUntilExit()

    let result = ExecuteBinaryResult(stdOut: stdOut, stdErr: stdErr)

    return (result, process.terminationStatus)
  }
}

// MARK: - PipeProtocol

protocol PipeProtocol {
  var fileHandleForReading: FileHandle { get }
  var fileHandleForWriting: FileHandle { get }
}

// MARK: - Pipe

extension Pipe: PipeProtocol {
}
