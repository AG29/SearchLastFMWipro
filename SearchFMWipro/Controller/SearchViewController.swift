//
//  SearchViewController.swift
//  SearchFMWipro
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//


import UIKit

enum SearchVisibleTab : Int {
    case none
    case albums
    case artists
    case songs
}

class SearchViewController: UIViewController, UIGestureRecognizerDelegate,UITextFieldDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var visibleTab: SearchVisibleTab!
    var searchString:String?
    @IBOutlet weak var detailView: DetailView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailListnerCountLbl: UILabel!
    @IBOutlet weak var detailPlayCountLbl: UILabel!
    @IBOutlet weak var detailNameLbl: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var indicator: UIView!
    @IBOutlet weak var hiddenArtistNameLbl: UILabel!
    @IBOutlet weak var hiddenAlbumNameLbl: UILabel!
    
    private let viewModel = LastFMSearchTableViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicator.startRotating()
        searchBar.searchTextField.delegate = self
        let segment: UISegmentedControl = UISegmentedControl(items: ["Albums", "Artists","Songs"])
           segment.sizeToFit()
           if #available(iOS 13.0, *) {
               segment.selectedSegmentTintColor = UIColor.red
           } else {
              segment.tintColor = UIColor.red
           }
        segment.selectedSegmentIndex = 0
        visibleTab = .albums
        segment.setTitleTextAttributes([NSAttributedString.Key.font :UIFont.systemFont(ofSize: 15)], for: .normal)
           self.navigationItem.titleView = segment
        
        segment.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.delegate = self
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
        
        if let search = searchString, search != "" {
            searchString = search.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            searchBar.text = searchString
            callSearchAPIs()
        }else {
            searchBar.searchTextField.becomeFirstResponder()
        }
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        searchTableView.allowsSelection = true
    }

    
    func callSearchAPIs() {
    showLoader()
    searchString = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if let search = searchString, search != "" {
            
            viewModel.getAlbum(searchString: search) { (success) in
                if (success) {
                DispatchQueue.main.async {
                       self.hideLoader()
                       self.searchTableView.reloadData()
                   }
                } else {
                    self.showError()
                }
                  }
            viewModel.getTrack(searchString: search) { (success) in
                if (success) {
                DispatchQueue.main.async {
                       self.hideLoader()
                       self.searchTableView.reloadData()
                    }
                } else {
                    self.showError()
                }
                   }
                   
            viewModel.getArtist(searchString: search) { (success) in
                if(success) {
                DispatchQueue.main.async {
                        self.hideLoader()
                        self.searchTableView.reloadData()
                    }
                } else
                {
                    self.showError()
                }
            }
        }
        
    }
    
    func showLoader() {
        self.view.bringSubviewToFront(self.indicator.superview!)
    }
    
    func hideLoader() {
         self.view.sendSubviewToBack(self.indicator.superview!)
    }
    
    @objc func hideKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    
 @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            visibleTab = .albums
        } else if sender.selectedSegmentIndex == 1 {
            visibleTab = .artists
        } else {
            visibleTab = .songs
        }
        resetDetail()
        searchTableView.reloadData()
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        callSearchAPIs()
        return true
    }
    
}

  // MARK: -
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
      // MARK: -
      // MARK: UITableView delegate methods
      
      
    func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if visibleTab == .artists {
          return viewModel.artistCount
      } else if visibleTab == .albums {
          return viewModel.albumCount
      } else if visibleTab == .songs {
          return viewModel.trackCount
      }
      return 0
      
      }
      
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          if visibleTab == .artists {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: LastFMArtistTableCell.reuseIdentifier,
                                                             for: indexPath) as? LastFMArtistTableCell else {
                  return UITableViewCell()
              }

              let cellViewModel = viewModel.cellViewModelArtist(index: indexPath.row)
              cell.viewModel = cellViewModel

              return cell
          } else if visibleTab == .albums {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: LastFMAlbumTableCell.reuseIdentifier,
                                                             for: indexPath) as? LastFMAlbumTableCell else {
                  return UITableViewCell()
              }

              let cellViewModel = viewModel.cellViewModelAlbum(index: indexPath.row)
              cell.viewModel = cellViewModel

              return cell
          } else if visibleTab == .songs {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: LastFMTrackTableCell.reuseIdentifier,
                                                             for: indexPath) as? LastFMTrackTableCell else {
                  return UITableViewCell()
              }

              let cellViewModel = viewModel.cellViewModelTrack(index: indexPath.row)
              cell.viewModel = cellViewModel

              return cell
          }
          return UITableViewCell()
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
          
          if visibleTab == .artists {
          if let cellViewModel = viewModel.cellViewModelArtist(index: indexPath.row) {
            DispatchQueue.main.async {
                self.showLoader()
                self.viewModel.getArtistDetail(artistName: cellViewModel.name) { (success) in
                    if(success) {
                  self.loadArtistDetail()
                    }
                    else {
                        self.showError()
                    }
              }
            }
          }
              
          } else if visibleTab == .albums {
              if let cellViewModel = viewModel.cellViewModelAlbum(index: indexPath.row) {
                DispatchQueue.main.async {
                    self.showLoader()
                    self.viewModel.getAlbumDetail(albumName: cellViewModel.name, artistName: cellViewModel.artist) { (success) in
                        if(success) {
                      self.loadAlbumDetail()
                        } else {
                            self.showError()
                        }
                  }
                }
              }
              
          } else if visibleTab == .songs {
              if let cellViewModel = viewModel.cellViewModelTrack(index: indexPath.row) {
                DispatchQueue.main.async {
                    self.showLoader()
                    self.viewModel.getTrackDetail(trackName: cellViewModel.name, artistName: cellViewModel.artist) { (success) in
                        if(success) {
                        self.loadTrackDetail()
                        } else
                        {
                            self.showError()
                        }
                  }
              }
            }
          }
      }
      
      func loadArtistDetail() {
          
        if let detailViewModel = self.viewModel.viewModelArtisDetail() {
        DispatchQueue.main.async {
          self.detailImageView.downloadImage(url: detailViewModel.artistMegaImagePath)
          self.detailNameLbl.text = detailViewModel.name
          self.detailListnerCountLbl.text = detailViewModel.listnerCount
          self.detailPlayCountLbl.text = detailViewModel.playCount
          self.detailView.isHidden = false
          self.blurView.isHidden = false
          self.hideLoader()
          }
        }
          
      }
      
      func loadAlbumDetail() {
          
        if let detailViewModel = self.viewModel.viewModelAlbumDetail() {
            DispatchQueue.main.async {
            self.detailImageView.downloadImage(url: detailViewModel.albumLargeImagePath)
            self.detailNameLbl.text = detailViewModel.name
            self.detailListnerCountLbl.text = detailViewModel.listnerCount
            self.detailPlayCountLbl.text = detailViewModel.playCount
            self.detailView.isHidden = false
            self.blurView.isHidden = false
            self.hideLoader()
            }
        }
      }
      
      func loadTrackDetail() {
          
        if let detailViewModel = self.viewModel.viewModelTrackDetail() {
        DispatchQueue.main.async {
            self.detailImageView.downloadImage(url: detailViewModel.trackAlbumLargeImagePath )
            self.detailNameLbl.text = detailViewModel.name
            self.detailListnerCountLbl.text = detailViewModel.listnerCount
            self.detailPlayCountLbl.text = detailViewModel.playCount
            self.hiddenArtistNameLbl.text = detailViewModel.artist
            self.hiddenAlbumNameLbl.text = detailViewModel.album
            self.hiddenAlbumNameLbl.isHidden = false
            self.hiddenArtistNameLbl.isHidden = false
            self.detailView.isHidden = false
            self.blurView.isHidden = false
            self.hideLoader()
            }
            
        }
          
      }
    
    @IBAction func returnButton(_ sender: Any) {
        resetDetail()
    }
    
    func resetDetail() {
        self.detailImageView.image = nil
        self.detailNameLbl.text = ""
        self.detailListnerCountLbl.text = ""
        self.detailPlayCountLbl.text = ""
        self.hiddenAlbumNameLbl.text = ""
        self.hiddenArtistNameLbl.text = ""
        self.detailView.isHidden = true
        self.blurView.isHidden = true
        self.hiddenAlbumNameLbl.isHidden = true
        self.hiddenArtistNameLbl.isHidden = true
        hideLoader()
    }
    
    func showError()
    {
        DispatchQueue.main.async {
        let alert = UIAlertController(title: "Error in Response", message: "Please try again in sometime",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            self.resetDetail()
        }))
        self.present(alert, animated: true, completion: nil)
        }
    }
}
