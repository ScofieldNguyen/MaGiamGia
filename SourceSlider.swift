//
//  SourceSlider.swift
//  MaGiamGia
//
//  Created by ScofieldNguyen on 7/26/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class TitleCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.white
        tl.font = UIFont.boldSystemFont(ofSize: 26)
        tl.textAlignment = .center
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    func setupViews() {
        self.backgroundColor = UIColor(colorLiteralRed: 84/255, green: 171/255, blue: 210/255, alpha: 1)
        
        addSubview(titleLabel)
        
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SourceCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var source: Source? {
        didSet {
            sourceImage.image = UIImage(named: (source?.sourceImageName)!)
        }
    }
    
    var sourceImage: UIImageView = {
        let si = UIImageView()
        si.translatesAutoresizingMaskIntoConstraints = false
        si.contentMode = .scaleAspectFill
        si.clipsToBounds = true
        return si
    }()
    
    func setupViews() {
        addSubview(sourceImage)
        
        sourceImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        sourceImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        sourceImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        sourceImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SourceSlider: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override init() {
        super.init()
        setupView()
    }
    
    let cellsItem = ["Chọn nguồn", "tiki", "lazada", "adayroi", "Công cụ", "magiamgia"]
    let isTitle = [true, false, false, false, true, false]
    
    let titleCellID = "titleCellID"
    let sourceCellID = "sourceCellID"
    
    lazy var statusBarHeight: CGFloat = {
        return UIApplication.shared.statusBarFrame.height
//        return 0
    }()
    
    lazy var collectionViewWidth: CGFloat = {
        var cw: CGFloat = 0
        if let window = UIApplication.shared.keyWindow {
            cw = window.frame.width * 2 / CGFloat(3)
        }
        return cw
    }()
    lazy var collectionViewHeight: CGFloat = {
        var windowHeight: CGFloat = 0
        if let window = UIApplication.shared.keyWindow {
            windowHeight = window.frame.height
        }
        return windowHeight - self.statusBarHeight
//        return windowHeight
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(TitleCell.self, forCellWithReuseIdentifier: self.titleCellID)
        cv.register(SourceCell.self, forCellWithReuseIdentifier: self.sourceCellID)
        return cv
    }()
    
    let blackBackgroundView : UIView = {
        let bv = UIView()
        return bv
    }()
    
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackBackgroundView.alpha = 0
            self.collectionView.frame = CGRect(x: -(self.collectionViewWidth), y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }) { (completed) in
            // Do something here...
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isTitle[indexPath.row] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellID, for: indexPath) as! TitleCell
            cell.titleLabel.text = cellsItem[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sourceCellID, for: indexPath) as! SourceCell
            let sourceName = cellsItem[indexPath.row]
            let sourceImageName = cellsItem[indexPath.row]
            cell.source = Source(sourceName: sourceName, sourceImageName: sourceImageName)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isTitle[indexPath.row] {
            return CGSize(width: collectionView.frame.width, height: 62)
        }else{
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func setupView() {
        if let window = UIApplication.shared.keyWindow {
            // Setup blackBackgroundView
            blackBackgroundView.backgroundColor = UIColor(white: 0, alpha: 0.2)
            blackBackgroundView.frame = window.frame
            // Hide blackBackgroundView by default
            blackBackgroundView.alpha = 0
            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackBackgroundView)
            
            // Setup collectionView
            window.addSubview(collectionView)
            collectionView.backgroundColor = UIColor.white
            collectionView.frame = CGRect(x: -(collectionViewWidth), y: 0, width: collectionViewWidth, height: window.frame.height)
            let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss))
            swipeLeftRecognizer.direction = .left
            collectionView.addGestureRecognizer(swipeLeftRecognizer)
            
        }
    }
    
    func show() {
        // Animate blackBackgroundView
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.blackBackgroundView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }) { (completed) in
            // Do something here...
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
