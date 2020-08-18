//
//  DetailViewModel.swift
//  SearchFMWipro
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation

class DetailViewModelAlbum {
    
    private let album: AlbumInfo

    init(albumDetail: AlbumInfo) {
        self.album = albumDetail
    }

    var name: String {
        return album.name ?? ""
    }

    var artist: String {
        return album.artist ?? ""
    }
    
    var listnerCount: String {
        return "Listners: \(album.listeners ?? "")"
    }

    var playCount: String {
        return "PlayCount: \(album.playcount ?? "")"
    }

    var published: String {
        return album.wiki?.published ?? "NA"
    }
    
    var albumLargeImagePath: String {
        if let count = album.image?.count, let image = album.image {
            return image[count-1].text
        } else {
            return ""
        }
        
    }
    
    
    

}

class DetailViewModelArtist {

    
    private let artist: ArtistDetailInfo

    init(artistDetail: ArtistDetailInfo) {
        self.artist = artistDetail
    }

    var name: String {
        return artist.name ?? ""
    }
    
    var listnerCount: String {
        return "Listners: \(artist.stats?.listeners ?? "")"
    }

    var playCount: String {
        return "PlayCount: \(artist.stats?.playcount ?? "")"
    }

    var published: String {
        return artist.bio?.published ?? ""
    }
    
    var artistMegaImagePath: String {
        if let image = artist.image {
            return image[image.count-1].text
        } else {
            return ""
        }
        
    }
    

}

class DetailViewModelTrack {

    private let track: TrackDetailInfo

    init(trackDetail: TrackDetailInfo) {
        self.track = trackDetail
    }

    var name: String {
        return track.name ?? ""
    }
    
    var artist: String {
        return "Artist: \(track.artist?.name ?? "")"
    }
    
    var album: String {
        return "Album: \(track.album?.title ?? "")"
    }
    
    var listnerCount: String {
        return "Listners: \(track.listeners ?? "")"
    }

    var playCount: String {
        return "PlayCount: \(track.playcount ?? "")"
    }

    var published: String {
        return track.wiki?.published ?? ""
    }
    
    var trackAlbumLargeImagePath: String {
        if let image = track.album?.image {
            return image[image.count-1].text
        }
        else {
            return ""
        }
        
    }
}
