//
//  ArtistSearch.swift
//  SearchFMWipro
//
//  Created by AG on 12/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

//   let artistSearch = try? newJSONDecoder().decode(ArtistSearch.self, from: jsonData)

import Foundation

// MARK: - ArtistSearch
struct ArtistSearch: Codable {
    let results: ArtistResults
}

// MARK: - Results
struct ArtistResults: Codable {
    let opensearchQuery: OpensearchQuery
    let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String
    let artistmatches: Artistmatches
    let attr: Attr

    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case artistmatches
        case attr = "@attr"
    }
}

// MARK: - Artistmatches
struct Artistmatches: Codable {
    let artist: [Artist]
}

// MARK: - Artist
struct Artist: Codable {
    let name, listeners, mbid: String
    let url: String
    let streamable: String
    let image: [Image]
}

enum Size: String, Codable {
    case extralarge = "extralarge"
    case large = "large"
    case medium = "medium"
    case mega = "mega"
    case small = "small"
}

