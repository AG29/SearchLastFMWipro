//
//  TrackDetail.swift
//  SearchFMWipro
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

//   let trackDetail = try? newJSONDecoder().decode(TrackDetail.self, from: jsonData)

import Foundation

// MARK: - TrackDetail
struct TrackDetail: Codable {
    let track: TrackDetailInfo
}

// MARK: - Track
struct TrackDetailInfo: Codable {
    let name, mbid: String?
    let url: String?
    let duration: String?
    let streamable: StreamableOfTrack?
    let listeners, playcount: String?
    let artist: ArtistOfTrack?
    let album: AlbumOfTrack?
    let toptags: Toptags?
    let wiki: WikiOfTrack?
    
    
    enum CodingKeys: String, CodingKey {
         case name,artist,mbid,url,album,listeners,playcount,duration,toptags,wiki,streamable
     }
     
    public init(from decoder: Decoder) throws {
         
        let values = try decoder.container(keyedBy: CodingKeys.self)
         name = try? values.decode(String.self, forKey: .name)
         artist = try? values.decode(ArtistOfTrack.self, forKey: .artist)
         mbid = try? values.decode(String.self, forKey: .mbid)
         url = try? values.decode(String.self, forKey: .url)
         album = try? values.decode(AlbumOfTrack.self, forKey: .album)
         listeners = try? values.decode(String.self, forKey: .listeners)
         playcount = try? values.decode(String.self, forKey: .playcount)
         duration = try? values.decode(String.self, forKey: .duration)
         toptags = try? values.decode(Toptags.self, forKey: .toptags)
         wiki = try? values.decode(WikiOfTrack.self, forKey: .wiki)
         streamable = try? values.decode(StreamableOfTrack.self, forKey: .streamable)
        
         
     }
     
     public func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try? container.encode(name, forKey: .name)
         try? container.encode(artist, forKey: .artist)
         try? container.encode(mbid, forKey: .mbid)
         try? container.encode(url, forKey: .url)
         try? container.encode(album, forKey: .album)
         try? container.encode(listeners, forKey: .listeners)
         try? container.encode(playcount, forKey: .playcount)
         try? container.encode(toptags, forKey: .toptags)
         try? container.encode(wiki, forKey: .wiki)
         try? container.encode(duration, forKey: .duration)
         try? container.encode(streamable, forKey: .streamable)
     }
    
    
}

// MARK: - Album
struct AlbumOfTrack: Codable {
    let artist, title, mbid: String
    let url: String
    let image: [ImageOfTrack]
    let attr: AttrOfTrack

    enum CodingKeys: String, CodingKey {
        case artist, title, mbid, url, image
        case attr = "@attr"
    }
}

// MARK: - Attr
struct AttrOfTrack: Codable {
    let position: String
}

// MARK: - Image
struct ImageOfTrack: Codable {
    let text: String
    let size: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

// MARK: - Artist
struct ArtistOfTrack: Codable {
    let name, mbid: String
    let url: String
}

// MARK: - Streamable
struct StreamableOfTrack: Codable {
    let text, fulltrack: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case fulltrack
    }
}

// MARK: - Toptags
struct Toptags: Codable {
    let tag: [TagOfTrack]
}

// MARK: - Tag
struct TagOfTrack: Codable {
    let name: String
    let url: String
}

// MARK: - Wiki
struct WikiOfTrack: Codable {
    let published, summary, content: String
}

