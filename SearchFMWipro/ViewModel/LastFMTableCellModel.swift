//
//  LastFMTableCellModel.swift
//  SearchFMWipro
//
//  Created by AG on 13/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation

class LastFMTableCellAlbumModel {

    private let album: Album

    init(album: Album) {
        self.album = album
    }

    var name: String {
        return album.name
    }

    var artist: String {
        return album.artist
    }

    var streamable: String {
        return album.streamable
    }

    var mbid: String {
        return album.mbid
    }
    
    var albumLargeImagePath: String {
        return album.image[album.image.count-1].text
    }
}

class LastFMTableCellArtistModel {

    private let artist: Artist

    init(artist: Artist) {
        self.artist = artist
    }

    var name: String {
        return artist.name
    }

    var listeners: String {
        return artist.listeners
    }
    
    var url: String {
        return artist.url
    }

    var streamable: String {
        return artist.streamable
    }

    var mbid: String {
        return artist.mbid
    }
    
    var artistLargeImagePath: String {
        return artist.image[artist.image.count-1].text
    }
}

class LastFMTableCellTrackModel {

    private let track: TrackObject

    init(track: TrackObject) {
        self.track = track
    }

    var name: String {
        return track.name
    }

    var artist: String {
        return track.artist
    }
    
    var url: String {
        return track.url
    }

    var streamable: String {
        return track.streamable.rawValue
    }

    var mbid: String {
        return track.mbid
    }
    
    var trackLargeImagePath: String {
        return track.image[track.image.count-1].text
    }
}
