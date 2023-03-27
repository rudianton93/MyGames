//
//  MyGamesTests.swift
//  MyGamesTests
//
//  Created by Rudi Anton on 09/03/23.
//

import XCTest
@testable import MyGames

final class MyGamesTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testInvalidInputSides() {
    XCTAssertThrowsError(try detectTriangle(-1, -2, -3)) { error in
      XCTAssertEqual(error as? TriangleError, TriangleError.invalidInput)
    }
  }
  
  func testDetectEquilateralTriangle() {
    XCTAssertEqual(try detectTriangle(2, 2, 2), "Segitiga Sama Sisi")
  }
  
  func testDetectIsoscelesTriangle() {
    XCTAssertEqual(try detectTriangle(1, 1, 2), "Segitiga Sama Kaki")
    XCTAssertEqual(try detectTriangle(1, 2, 1), "Segitiga Sama Kaki")
    XCTAssertEqual(try detectTriangle(1, 2, 2), "Segitiga Sama Kaki")
    XCTAssertEqual(try detectTriangle(2, 1, 2), "Segitiga Sama Kaki")
  }
  
  func detectTriangle(
    _ sideA: Int,
    _ sideB: Int,
    _ sideC: Int
  ) throws -> String {
    let sides = [sideA, sideB, sideC].sorted()
    for side in sides where side < 0 {
      throw TriangleError.invalidInput
    }
    if sides[0] == sides[1] && sides[0] == sides[2] {
      return "Segitiga Sama Sisi"
    } else if sides[0] == sides[1] || sides[1] == sides[2] {
      return "Segitiga Sama Kaki"
    } else {
      return "Bukan Segitiga Sama Kaki dan Segitiga Sama Sisi"
    }
  }
}

enum TriangleError: Error {
  case invalidInput
}
