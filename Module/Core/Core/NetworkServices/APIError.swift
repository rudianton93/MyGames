//
//  APIError.swift
//  MyGames
//
//  Created by Rudi Anton on 10/03/23.
//

enum ApiError: Error {
  case connectionError
  case invalidJSONError
  case middlewareError(code: Int, message: String?)
  case failedMappingError
  
  var localizedDescription: String {
    switch self {
    case .connectionError:
      return "error Connection"
    case .invalidJSONError:
      return "error JSON"
    case .middlewareError(_, let message):
      return message ?? ""
    case .failedMappingError:
      return "error Format"
    }
  }
}
