//
//  Extension.swift
//  MaGiamGia
//
//  Created by ScofieldNguyen on 6/20/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintWithFormat(format: String, views: UIView...) {
        var dictionaryViews = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            dictionaryViews[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionaryViews))
    }
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        
        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 6
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageURLString: String?
    func loadImageFromURLString(urlString: String) {
        self.imageURLString = urlString
        
        if let img = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = img
            return
        }
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            if urlString == self.imageURLString {
                DispatchQueue.main.async {
                    let loadedImage = UIImage(data: data!)
                    imageCache.setObject(loadedImage!, forKey: NSString(string: urlString))
                    self.image = loadedImage
                }
            }
            
            }.resume()
    }
}
