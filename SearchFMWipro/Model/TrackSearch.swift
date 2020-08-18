//
//  TrackSearch.swift
//  SearchFMWipro
//
//  Created by AG on 12/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

//   let trackSearch = try? newJSONDecoder().decode(TrackSearch.self, from: jsonData)

import Foundation

// MARK: - TrackSearch
struct TrackSearch: Codable {
    let results: TrackResults
}

// MARK: - Results
struct TrackResults: Codable {
    let opensearchQuery: TrackOpensearchQuery
    let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String
    let trackmatches: Trackmatches
    let attr: TrackAttr

    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case trackmatches
        case attr = "@attr"
    }
}

// MARK: - Attr
struct TrackAttr: Codable {
}

// MARK: - OpensearchQuery
struct TrackOpensearchQuery: Codable {
    let text, role, startPage: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role, startPage
    }
}

// MARK: - Trackmatches
struct Trackmatches: Codable {
    let track: [TrackObject]
}

// MARK: - Track
struct TrackObject: Codable {
    let name, artist: String
    let url: String
    let streamable: TrackStreamable
    let listeners: String
    let image: [TrackImage]
    let mbid: String
}

// MARK: - Image
struct TrackImage: Codable {
    let text: String
    let size: TrackSize

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

enum TrackSize: String, Codable {
    case extralarge = "extralarge"
    case large = "large"
    case medium = "medium"
    case small = "small"
}

enum TrackStreamable: String, Codable {
    case fixme = "FIXME"
}
