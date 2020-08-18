//
//  ArtistDetail.swift
//  SearchFMWipro
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

//   let artistDetail = try? newJSONDecoder().decode(ArtistDetail.self, from: jsonData)

import Foundation

// MARK: - ArtistDetail
struct ArtistDetail: Codable {
    let artist: ArtistDetailInfo
}

// MARK: - ArtistDetailArtist
struct ArtistDetailInfo: Codable {
    let name, mbid: String?
    let url: String?
    let image: [ImageOfArtist]?
    let streamable, ontour: String?
    let stats: Stats?
    let similar: Similar?
    let tags: TagsForArtist?
    let bio: Bio?
    
    enum CodingKeys: String, CodingKey {
           case name,mbid,url,image,streamable,ontour,tags,stats,similar,bio
       }
       
      public init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           name = try? values.decode(String.self, forKey: .name)
           mbid = try? values.decode(String.self, forKey: .mbid)
           url = try? values.decode(String.self, forKey: .url)
           image = try? values.decode([ImageOfArtist].self, forKey: .image)
           streamable = try? values.decode(String.self, forKey: .streamable)
           ontour = try? values.decode(String.self, forKey: .ontour)
           tags = try? values.decode(TagsForArtist.self, forKey: .tags)
           bio = try? values.decode(Bio.self, forKey: .bio)
           stats = try? values.decode(Stats.self, forKey: .stats)
           similar = try? values.decode(Similar.self, forKey: .similar)
           
       }
       
       public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try? container.encode(name, forKey: .name)
           try? container.encode(stats, forKey: .stats)
           try? container.encode(mbid, forKey: .mbid)
           try? container.encode(url, forKey: .url)
           try? container.encode(image, forKey: .image)
           try? container.encode(bio, forKey: .bio)
           try? container.encode(similar, forKey: .similar)
           try? container.encode(tags, forKey: .tags)
           try? container.encode(streamable, forKey: .streamable)
           try? container.encode(ontour, forKey: .ontour)
       }
}

// MARK: - Bio
struct Bio: Codable {
    let links: Links
    let published, summary, content: String
}

// MARK: - Links
struct Links: Codable {
    let link: Link
}

// MARK: - Link
struct Link: Codable {
    let text, rel: String
    let href: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case rel, href
    }
}

// MARK: - Image
struct ImageOfArtist: Codable {
    let text: String
    let size: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

// MARK: - Similar
struct Similar: Codable {
    let artist: [ArtistElement]
}

// MARK: - ArtistElement
struct ArtistElement: Codable {
    let name: String
    let url: String
    let image: [ImageOfArtist]
}

// MARK: - Stats
struct Stats: Codable {
    let listeners, playcount: String
    
    enum CodingKeys: String, CodingKey {
        case listeners = "listeners"
        case playcount = "playcount"
    }
}

// MARK: - Tags
struct TagsForArtist: Codable {
    let tag: [TagForArtist]
}

// MARK: - Tag
struct TagForArtist: Codable {
    let name: String
    let url: String
}

