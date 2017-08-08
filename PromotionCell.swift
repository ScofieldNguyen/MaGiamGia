//
//  PromotionCell.swift
//  MaGiamGia
//
//  Created by ScofieldNguyen on 6/20/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    var promotion: Promotion? {
        didSet{
            titleView.text = promotion?.title
            subtitleView.text = promotion?.subtitle
            dateView.text = promotion?.experationDate
        }
    }
    
    let discountDetailView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "saleoff")
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateView: UILabel = {
        let label = UILabel()
        label.text = "15/05/17"
        label.textColor = UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.5)
        label.font = label.font.withSize(8)
        return label
    }()
    
    let titleView: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 11)
//        label.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.isScrollEnabled = false
//        label.isEditable = false
        return label
    }()
    
    let subtitleView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(colorLiteralRed: 78/255, green: 71/255, blue: 71/255, alpha: 0.5)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
//        label.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.isEditable = false
//        label.isSelectable = false
        return label
    }()
    
    let seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 216/255, green: 216/255, blue: 226/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.backgroundColor = UIColor.white
        self.dropShadow()
        
        
        addSubview(discountDetailView)
        addSubview(dateView)
        addSubview(titleView)
        addSubview(subtitleView)
        addSubview(seperateView)
        
        addConstraintWithFormat(format: "V:|-30-[v0(60)]", views: discountDetailView)
        addConstraintWithFormat(format: "H:|-16-[v0(60)]-16-[v1]-16-|", views: discountDetailView, dateView)
        
        addConstraintWithFormat(format: "V:|-16-[v0(10)]", views: dateView)
        
        addConstraintWithFormat(format: "V:[v0(10)]|", views: seperateView)
        addConstraintWithFormat(format: "H:|[v0]|", views: seperateView)
        
        // Top constraints
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: dateView, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleView, attribute: .top, relatedBy: .equal, toItem: titleView, attribute: .bottom, multiplier: 1, constant: 4))
        // Left constraints
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .left, relatedBy: .equal, toItem: dateView, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleView, attribute: .left, relatedBy: .equal, toItem: dateView, attribute: .left, multiplier: 1, constant: 0))
        // Right constraints
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .right, relatedBy: .equal, toItem: dateView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleView, attribute: .right, relatedBy: .equal, toItem: dateView, attribute: .right, multiplier: 1, constant: 0))
        // Height constraints
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 27))
        addConstraint(NSLayoutConstraint(item: subtitleView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 50))
    }
    
}

