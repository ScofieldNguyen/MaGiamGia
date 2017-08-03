//
//  ViewController.swift
//  MaGiamGia
//
//  Created by ScofieldNguyen on 6/10/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var promotions: [Promotion]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPromotions()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(PromotionCell.self, forCellWithReuseIdentifier: "Cell")
        
        setupTitle()
        setupNavigationBarItem()
        setupEdgeSwipeGesture()
        
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    lazy var sourceSlider: SourceSlider = {
        let sl = SourceSlider()
        return sl
    }()
    
    func setupTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Tiki"
        titleLabel.textColor = UIColor.white
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        navigationItem.titleView = titleLabel
    }
    
    func setupEdgeSwipeGesture() {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
    }
    
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .began || recognizer.state == .changed {
            sourceSlider.show()
//            let translation = recognizer.translation(in: self.view)
//            if sourceSlider.collectionView.center.x <
//            sourceSlider.collectionView.center = CGPoint(x: sourceSlider.collectionView.center.x + translation.x, y: sourceSlider.collectionView.center.y)
//            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    func setupNavigationBarItem() {
        let moreButtonImage = UIImage(named: "ic_dehaze_white")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreButtonImage, style: .plain, target: self, action: #selector(handelMoreButton))
        
        let searchButtonImage = UIImage(named: "ic_search_white")?.withRenderingMode(.alwaysOriginal)
        let searchButtonItem = UIBarButtonItem(image: searchButtonImage, style: .plain, target: self, action: #selector(handelSearchButton))
        
        navigationItem.leftBarButtonItems = [moreButtonItem]
        navigationItem.rightBarButtonItems = [searchButtonItem]
    }
    
    func handelMoreButton() {
        // Show sourceSlider
        sourceSlider.show()
    }
    
    func handelSearchButton() {
        
    }
    
    func loadPromotions() {
        if let path = Bundle.main.path(forResource: "promoJson", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url, options:
                    Data.ReadingOptions.mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: AnyObject]]
                promotions = [Promotion]()
                for dictionary in json {
                    let promo = Promotion()
                    promo.title = dictionary["title"] as? String
                    promo.subtitle = dictionary["subtitle"] as? String
                    promo.experationDate = dictionary["experationDate"] as? String
                    promo.siteName = dictionary["siteName"] as? String
                    promo.thumbnailImage = dictionary["thumbnailImage"] as? String
                    promo.content = dictionary["content"] as? String
                    
                    promotions?.append(promo)
                }
                
                collectionView?.reloadData()
                
            } catch {
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promotions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 130)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PromotionCell
        cell.promotion = promotions?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, 0, 15, 0)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
