//
//  UIImageView+Download.swift
//  SearchFMWipro
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import UIKit

@objc extension UIImageView
{
    private struct AssociatedKeys {
      fileprivate static var imageURL = "imageURL"
      fileprivate static var imageDownloadQueue = "imageDownloadQueue"
    }

    private static var cacheMemory : [ String : UIImage ] = [:]
    
    var imageURL: String?
    {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.imageURL) as? String
        }
        
        set
        {
            if let newValue = newValue
            {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.imageURL,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }

    private var imageDownloadQueue: OperationQueue?
    {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.imageDownloadQueue) as? OperationQueue
        }
        
        set
        {
            if let newValue = newValue
            {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.imageDownloadQueue,
                    newValue as OperationQueue?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    
    private func showLoader()
    {
        let subView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: self.bounds.size))
        subView.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        let imageView = UIImageView(image: UIImage(named: "Loader"))

        var widthForLoader = self.bounds.size.height < self.bounds.size.width ? self.bounds.size.height : self.bounds.size.width
        widthForLoader = widthForLoader/2.0;
        
        imageView.frame.size.height = widthForLoader
        imageView.frame.size.width = widthForLoader
        imageView.frame.origin.y = (self.bounds.height - widthForLoader)/2.0
        imageView.frame.origin.x = (self.bounds.width - (widthForLoader))/2.0

        imageView.startRotating()
        subView.addSubview(imageView)
        self.removeAllSubViews()
        self.addSubview(subView)
    }
    
    private func show(image : UIImage, resizeHeight : Bool = false) {
        self.removeAllSubViews()
        self.image = image
        if resizeHeight {
            self.frame.size.height = self.frame.size.height/self.frame.size.width * UIImageView(image: image).frame.size.width
        }
    }

    @objc func downloadImage(url : String) {
        self.downloadImage(url: url, resizeHeight: false)
    }

    @objc func downloadImage(url : String, resizeHeight : Bool) {
        
        if let img = Self.cacheMemory[url] {
            self.show(image: img, resizeHeight: resizeHeight)
            return
        }
        
        if let imageURL =  URL(string: url)
        {
            self.imageURL = url
            self.showLoader()
            imageDownloadQueue?.cancelAllOperations()
            imageDownloadQueue = OperationQueue()
            imageDownloadQueue?.addOperation
            {
                if let data = try? Data(contentsOf: imageURL)
                {
                    DispatchQueue.main.async
                    {
                        if self.imageURL == url, let img = UIImage(data: data)
                        {
                            Self.cacheMemory[url] = img
                            self.show(image: img, resizeHeight: resizeHeight)
                        }
                    }
                }
                else
                {
                    DispatchQueue.main.async
                    {
                        self.removeAllSubViews()
                    }
                }
            }
        }
    }
}
