//
//  LastFMSearchTableViewModel.swift
//  SearchFMWipro
//
//  Created by AG on 13/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation

class LastFMSearchTableViewModel {

    private let networking = Networking()
    
    private var albums: AlbumSearch?
    
    private var artists: ArtistSearch?
    
    private var tracks: TrackSearch?

    private var albumDetail: AlbumDetail?

    private var artistDetail: ArtistDetail?

    private var trackDetail: TrackDetail?

    public func getAlbum(searchString: String,
                             completion: ((_ success:Bool) -> Void)?) {
        
        networking.performNetworkTaskForLastFMAPI(endpoint: LastFmAPI.albumSearch(albumName: searchString), type: AlbumSearch.self) { [weak self] (response, success) in
            self?.albums = response
            completion?(success)
        }
        
    }
    
    public func getTrack(searchString: String,
                             completion: ((_ success:Bool) -> Void)?) {
        
        networking.performNetworkTaskForLastFMAPI(endpoint: LastFmAPI.trackSearch(trackName: searchString), type: TrackSearch.self) { [weak self] (response, success) in
            self?.tracks = response
            completion?(success)
        }
        
    }
    
    public func getArtist(searchString: String,
                             completion: ((_ success:Bool) -> Void)?) {
        
        networking.performNetworkTaskForLastFMAPI(endpoint: LastFmAPI.artistSearch(artistName: searchString), type: ArtistSearch.self) { [weak self] (response, success) in
            self?.artists = response
            completion?(success)
        }
        
    }
    
    public func getArtistDetail(artistName: String,
                                completion: ((_ success:Bool) -> Void)?) {
        
        networking.performNetworkTaskForLastFMAPI(endpoint: LastFmAPI.artistDetailFor(artistName: artistName), type: ArtistDetail.self) { [weak self] (response, success) in
            self?.artistDetail = response
            completion?(success)
        }
        
    }
    
    public func getTrackDetail(trackName: String, artistName: String,
                             completion: ((_ success:Bool) -> Void)?) {
        
        networking.performNetworkTaskForLastFMAPI(endpoint: LastFmAPI.trackDetailFor(artist: artistName, track: trackName), type: TrackDetail.self) { [weak self] (response, success) in
            self?.trackDetail = response
            completion?(success)
        }
        
    }
    
    public func getAlbumDetail(albumName: String, artistName: String,
                             completion: ((_ success:Bool) -> Void)?) {
        
        networking.performNetworkTaskForLastFMAPI(endpoint: LastFmAPI.albumDetailFor(artist: artistName, album: albumName), type: AlbumDetail.self) { [weak self] (response, success) in
            self?.albumDetail = response
            completion?(success)
        }
        
    }
    
    public func cellViewModelAlbum(index: Int) -> LastFMTableCellAlbumModel? {
           guard let albums = albums else { return nil }
        let albumTableViewCellModel = LastFMTableCellAlbumModel(album: albums.results.albummatches.album[index])
           return albumTableViewCellModel
       }
    
    
    public func cellViewModelArtist(index: Int) -> LastFMTableCellArtistModel? {
           guard let artists = artists else { return nil }
           let artistTableViewCellModel = LastFMTableCellArtistModel(artist: artists.results.artistmatches.artist[index])
           return artistTableViewCellModel
       }
    
    
    public func cellViewModelTrack(index: Int) -> LastFMTableCellTrackModel? {
           guard let tracks = tracks else { return nil }
           let trackTableViewCellModel = LastFMTableCellTrackModel(track: tracks.results.trackmatches.track[index])
           return trackTableViewCellModel
       }
    
    public func viewModelAlbumDetail() -> DetailViewModelAlbum? {
        guard let albumDetail = albumDetail else { return nil }
        let trackTableViewCellModel = DetailViewModelAlbum(albumDetail: albumDetail.album)
        return trackTableViewCellModel
    }
    
    public func viewModelArtisDetail() -> DetailViewModelArtist? {
        guard let artistDetail = artistDetail else { return nil }
        let trackTableViewCellModel = DetailViewModelArtist(artistDetail: artistDetail.artist)
        return trackTableViewCellModel
    }
    
    public func viewModelTrackDetail() -> DetailViewModelTrack? {
        guard let trackDetail = trackDetail else { return nil }
        let trackTableViewCellModel = DetailViewModelTrack(trackDetail: trackDetail.track)
        return trackTableViewCellModel
    }
    
    
    
    public var artistCount: Int {
        return artists?.results.artistmatches.artist.count ?? 0
    }
    public var trackCount: Int {
        return tracks?.results.trackmatches.track.count ?? 0
    }
    public var albumCount: Int {
        return albums?.results.albummatches.album.count ?? 0
    }

}
