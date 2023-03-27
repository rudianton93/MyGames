//
//  Entity.swift
//  Common
//
//  Created by Rudi Anton on 27/03/23.
//

public struct DataGames: Codable {
  let status: String?
  public let results: [Games]?
  
  enum CodingKeys: String, CodingKey {
    case status = "status"
    case results = "results"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    status = try values.decodeIfPresent(String.self, forKey: .status)
    results = try values.decodeIfPresent([Games].self, forKey: .results)
  }
}

public struct Games: Codable {
  public let id: Int64?
  let slug: String?
  public let name: String?
  public let released: String?
  public let backgroundImage: String?
  public let rating: Float?
  let saturatedColor: String?
  let dominantColor: String?
  let genres: [Genres]?
  let clip: Clip?
  let shortScreenshots: [ShortScreenshots]?
  public let descriptionRaw: String?
  public let platforms: [Platforms]?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case slug = "slug"
    case name = "name"
    case released = "released"
    case backgroundImage = "background_image"
    case rating = "rating"
    case saturatedColor = "saturated_color"
    case dominantColor = "dominant_color"
    case genres = "genres"
    case clip = "clip"
    case shortScreenshots = "short_screenshots"
    case descriptionRaw = "description_raw"
    case platforms = "platforms"
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
    genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
    clip = try values.decodeIfPresent(Clip.self, forKey: .clip)
    shortScreenshots = try values.decodeIfPresent([ShortScreenshots].self, forKey: .shortScreenshots)
    descriptionRaw = try values.decodeIfPresent(String.self, forKey: .descriptionRaw)
    platforms = try values.decodeIfPresent([Platforms].self, forKey: .platforms)
  }
}

public struct Genres: Codable {
  let id: Int?
  let name: String?
  let slug: String?
  let gamesCount: Int?
  let imageBackground: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case slug = "slug"
    case gamesCount = "games_count"
    case imageBackground = "image_background"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name)
    slug = try values.decodeIfPresent(String.self, forKey: .slug)
    gamesCount = try values.decodeIfPresent(Int.self, forKey: .gamesCount)
    imageBackground = try values.decodeIfPresent(String.self, forKey: .imageBackground)
  }
}

public struct Clip: Codable {
  let clip: String?
  let clips: Clips?
  let preview: String?
  
  enum CodingKeys: String, CodingKey {
    case clip = "clip"
    case clips = "clips"
    case preview = "preview"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    clip = try values.decodeIfPresent(String.self, forKey: .clip)
    clips = try values.decodeIfPresent(Clips.self, forKey: .clips)
    preview = try values.decodeIfPresent(String.self, forKey: .preview)
  }
}

public struct Clips: Codable {
  let quality320: String?
  let quality640: String?
  let fullQuality: String?
  
  enum CodingKeys: String, CodingKey {
    case quality320 = "320"
    case quality640 = "640"
    case fullQuality = "full"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    quality320 = try values.decodeIfPresent(String.self, forKey: .quality320)
    quality640 = try values.decodeIfPresent(String.self, forKey: .quality640)
    fullQuality = try values.decodeIfPresent(String.self, forKey: .fullQuality)
  }
}

public struct ShortScreenshots: Codable {
  let id: Int?
  let image: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case image = "image"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    image = try values.decodeIfPresent(String.self, forKey: .image)
  }
}

public struct Platforms: Codable {
  public let platform: PlatformsDetail?
  
  enum CodingKeys: String, CodingKey {
    case platform = "platform"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    platform = try values.decodeIfPresent(PlatformsDetail.self, forKey: .platform)
  }
}

public struct PlatformsDetail: Codable {
  let id: Int?
  public let name: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
  }
  
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(Int.self, forKey: .id)
    name = try values.decodeIfPresent(String.self, forKey: .name)
  }
}
