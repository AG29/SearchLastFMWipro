//
//  LastFmAPI.swift
//  SearchFMWipro
//
//  Created by AG on 12/08/20.
//  Copyright © 2020 AG. All rights reserved.
//


import Foundation

enum LastFmAPI {
    case trackSearch(trackName: String)
    case albumSearch(albumName: String)
    case artistSearch(artistName: String)
    case trackDetailFor(artist: String, track: String)
    case albumDetailFor(artist: String, album: String)
    case artistDetailFor(artistName: String)
}

extension LastFmAPI: EndpointType {
    var baseURL: URL {
        return URL(string: Constants.APPURL.baseURL)!
    }

    var path: String {
        switch self {
        case .trackSearch(let trackName):
            return "/2.0/?method=track.search&track=\(trackName)&api_key=\(Constants.Keys.LastFmAPI.apiKey)&format=json"
        case .albumSearch(let albumName):
            return "/2.0/?method=album.search&album=\(albumName)&api_key=\(Constants.Keys.LastFmAPI.apiKey)&format=json"
        case .artistSearch(let artistName):
            return "/2.0/?method=artist.search&artist=\(artistName)&api_key=\(Constants.Keys.LastFmAPI.apiKey)&format=json"
        case .trackDetailFor(let artist, let track):
            return "/2.0/?method=track.getInfo&api_key=\(Constants.Keys.LastFmAPI.apiKey)&artist=\(artist)&track=\(track)&format=json"
        case .albumDetailFor(let artist,let album):
            return "/2.0/?method=album.getinfo&api_key=\(Constants.Keys.LastFmAPI.apiKey)&artist=\(artist)&album=\(album)&format=json"
        case .artistDetailFor(let artistName):
            return "2.0/?method=artist.getinfo&artist=\(artistName)&api_key=\(Constants.Keys.LastFmAPI.apiKey)&format=json"
        }
    }
}
