//
//  FavoritEntity.swift
//  MyGames
//
//  Created by Rudi Anton on 15/03/23.
//

import Foundation

public struct Favorit {
  let id: Int64?
  let name: String?
  let released: String?
  let backgroundImage: String?
  let rating: Float?
  let platforms: String?
}

public struct FavoritGames: Codable {
  let id: Int64?
  let slug: String?
  let name: String?
  let released: String?
  let backgroundImage: String?
  let rating: Float?
  let saturatedColor: String?
  let dominantColor: String?
//  let genres: [Genres]?
//  let clip: Clip?
//  let shortScreenshots: [ShortScreenshots]?
  let descriptionRaw: String?
//  let platforms: [Platforms]?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case slug = "slug"
    case name = "name"
    case released = "released"
    case backgroundImage = "background_image"
    case rating = "rating"
    case saturatedColor = "saturated_color"
    case dominantColor = "dominant_color"
//    case genres = "genres"
//    case clip = "clip"
//    case shortScreenshots = "short_screenshots"
    case descriptionRaw = "description_raw"
//    case platforms = "platforms"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(Int64.self, forKey: .id)
    slug = try values.decodeIfPresent(String.self, forKey: .slug)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    released = try values.decodeIfPresent(String.self, forKey: .released)
    backgroundImage = try values.decodeIfPresent(String.self, forKey: .backgroundImage)
    rating = try values.decodeIfPresent(Float.self, forKey: .rating)
    saturatedColor = try values.decodeIfPresent(String.self, forKey: .saturatedColor)
    dominantColor = try values.decodeIfPresent(String.self, forKey: .dominantColor)
//    genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
//    clip = try values.decodeIfPresent(Clip.self, forKey: .clip)
//    shortScreenshots = try values.decodeIfPresent([ShortScreenshots].self, forKey: .shortScreenshots)
    descriptionRaw = try values.decodeIfPresent(String.self, forKey: .descriptionRaw)
//    platforms = try values.decodeIfPresent([Platforms].self, forKey: .platforms)
  }
}
