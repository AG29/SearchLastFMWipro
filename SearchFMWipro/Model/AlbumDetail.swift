//
//  AlbumDetail.swift
//  SearchFMWipro
//
//  Created by AG on 13/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

//   let albumDetail = try? newJSONDecoder().decode(AlbumDetail.self, from: jsonData)

import Foundation

// MARK: - AlbumDetail
struct AlbumDetail: Codable {
    let album: AlbumInfo
}

// MARK: - Album
struct AlbumInfo: Codable {
    let name: String?
    let artist: String?
    let mbid: String?
    let url: String?
    let image: [ImageOfAlbum]?
    let listeners, playcount: String?
    let tracks: Tracks?
    let tags: Tags?
    let wiki: Wiki?
    
    enum CodingKeys: String, CodingKey {
        case name,artist,mbid,url,image,listeners,playcount,tracks,tags,wiki
    }
    
   public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decode(String.self, forKey: .name)
        artist = try? values.decode(String.self, forKey: .artist)
        mbid = try? values.decode(String.self, forKey: .mbid)
        url = try? values.decode(String.self, forKey: .url)
        image = try? values.decode([ImageOfAlbum].self, forKey: .image)
        listeners = try? values.decode(String.self, forKey: .listeners)
        playcount = try? values.decode(String.self, forKey: .playcount)
        tags = try? values.decode(Tags.self, forKey: .tags)
        wiki = try? values.decode(Wiki.self, forKey: .wiki)
        tracks = try? values.decode(Tracks.self, forKey: .tracks)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(name, forKey: .name)
        try? container.encode(artist, forKey: .artist)
        try? container.encode(mbid, forKey: .mbid)
        try? container.encode(url, forKey: .url)
        try? container.encode(image, forKey: .image)
        try? container.encode(listeners, forKey: .listeners)
        try? container.encode(playcount, forKey: .playcount)
        try? container.encode(tags, forKey: .tags)
        try? container.encode(wiki, forKey: .wiki)
        try? container.encode(tracks, forKey: .tracks)
    }
    
}

// MARK: - Image
struct ImageOfAlbum: Codable {
    let text: String
    let size: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

// MARK: - Tags
struct Tags: Codable {
    let tag: [Tag]
}

// MARK: - Tag
struct Tag: Codable {
    let name: String
    let url: String
}

// MARK: - Tracks
struct Tracks: Codable {
    let track: [TrackOfAlbum]?
    
    enum CodingKeys: String, CodingKey {
        case track = "track"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        track = try? container.decode([TrackOfAlbum].self, forKey: .track)
    }
    
    public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try? container.encode(track, forKey: .track)
    }
}

// MARK: - Track
struct TrackOfAlbum: Codable {
    let name: String
    let url: String
    let duration: String
    let attr: AttrOfAlbum
    let streamable: Streamable
    let artist: ArtistClass

    enum CodingKeys: String, CodingKey {
        case name, url, duration
        case attr = "@attr"
        case streamable, artist
    }
}

// MARK: - ArtistClass
struct ArtistClass: Codable {
    let name: String
    let mbid: String
    let url: String
}

// MARK: - Attr
struct AttrOfAlbum: Codable {
    let rank: String
}

// MARK: - Streamable
struct Streamable: Codable {
    let text, fulltrack: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case fulltrack
    }
}

// MARK: - Wiki
struct Wiki: Codable {
    let published, summary, content: String
}

