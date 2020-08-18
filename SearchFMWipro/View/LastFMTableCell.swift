//
//  LastFMTableCell.swift
//  SearchFMWipro
//
//  Created by AG on 13/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation

import UIKit

class LastFMAlbumTableCell: UITableViewCell {

    public static let reuseIdentifier = "AlbumCellID"

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumNameLbl: UILabel!
    
    public var viewModel: LastFMTableCellAlbumModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            self.albumNameLbl.text = viewModel.name
            self.albumImage.downloadImage(url: viewModel.albumLargeImagePath)
            
//            repoNameLabel.text = viewModel.name
//            descriptionLabel.text = viewModel.desc
//            languageNameLabel.text = viewModel.language
//            starCountLabel.text = viewModel.starsCount
        }
    }

}

class LastFMArtistTableCell: UITableViewCell {

    public static let reuseIdentifier = "ArtistCellID"

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!

    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistNameLbl: UILabel!
    
    public var viewModel: LastFMTableCellArtistModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.artistNameLbl.text = viewModel.name
            self.artistImage.downloadImage(url: viewModel.artistLargeImagePath)
//            descriptionLabel.text = viewModel.desc
//            languageNameLabel.text = viewModel.language
//            starCountLabel.text = viewModel.starsCount
        }
    }

}

class LastFMTrackTableCell: UITableViewCell {

    public static let reuseIdentifier = "TrackCellID"

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!

    
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackNameLbl: UILabel!
    
    public var viewModel: LastFMTableCellTrackModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.trackNameLbl.text = viewModel.name
            self.trackImage.downloadImage(url: viewModel.trackLargeImagePath)
//            descriptionLabel.text = viewModel.desc
//            languageNameLabel.text = viewModel.language
//            starCountLabel.text = viewModel.starsCount
        }
    }

}
