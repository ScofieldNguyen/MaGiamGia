//
//  ModalViewController.swift
//  MaGiamGia
//
//  Created by ScofieldNguyen on 8/5/17.
//  Copyright © 2017 ScofieldNguyen. All rights reserved.
//

import UIKit
import SafariServices

class ModalViewController: UIViewController {
    
    var interactor: Interacter? = nil
    var promotion: Promotion? {
        didSet {
            titleLabel.text = promotion?.title
            contentLabel.text = promotion?.content
            imageView.loadImageFromURLString(urlString: promotion!.thumbnailImage!)
            expiredDay2.text = promotion?.experationDate
        }
    }
    
    var homeController: HomeController?
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleGesture(sender:)))
        self.view.addGestureRecognizer(panGesture)
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blackView.alpha = 1
    }
    
    let blackView: UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = UIColor(colorLiteralRed: 84/255, green: 171/255, blue: 210/255, alpha: 1)
//        bv.backgroundColor = UIColor.black
        return bv
    }()
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = "Hè thả ga - Không lo về giá - Đặt vé bay ngay - tặng liền tay 500K"
        tl.numberOfLines = 0
        tl.font = UIFont.boldSystemFont(ofSize: 18)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let contentLabel: UILabel = {
        let tl = UILabel()
        tl.text = "+ Thời gian: 16.06.2017 - 30.06.2017. SGK không lợi nhuận. \n+ Tặng ngay Bộ dụng cụ học tập khi mua trọn bộ SGK & Sách tham khảo. \n+ Freeship dù chỉ 1 quyển cho đơn hàng HCM & HN. Freeship toàn quốc cho đơn hàng từ 90K. "
        tl.numberOfLines = 0
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 12)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.loadImageFromURLString(urlString: "https://img.masoffer.net/images/public_html/cdn.masoffer.net/stg/images/2017/06/28/1498637182_b4c7bde6399e0f9ea38ccbec265e926a_52887.png")
        iv.contentMode = .top
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let expiredDay1: UILabel = {
        let tl = UILabel()
        tl.text = "Ngày hết hạn"
        tl.font = UIFont.systemFont(ofSize: 12)
        tl.textColor = UIColor.lightGray
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let separateView: UIView = {
        let sv = UIView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = UIColor(colorLiteralRed: 84/255, green: 171/255, blue: 210/255, alpha: 1)
        sv.alpha = 0.7
        return sv
    }()
    
    let expiredDay2: UILabel = {
        let tl = UILabel()
        tl.text = "30-9-2017"
        tl.font = UIFont.boldSystemFont(ofSize: 12)
        tl.textColor = UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.5)
        tl.translatesAutoresizingMaskIntoConstraints = false
        return tl
    }()
    
    let toolBarBackground: UIView = {
        let sv = UIView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = UIColor(colorLiteralRed: 84/255, green: 171/255, blue: 210/255, alpha: 1)
        sv.alpha = 1
        return sv
    }()
    
    let shareButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.setImage((UIImage(named: "share")?.withRenderingMode(.alwaysTemplate)), for: .normal)
        sb.addTarget(self, action: #selector(handleShareButton(sender:)), for: .touchUpInside)
        sb.tintColor = UIColor.white
        return sb
    }()
    
    func handleShareButton(sender: UIButton) {
        let promoLink = NSURL(string: (promotion?.link)!)
        let activityController = UIActivityViewController(activityItems: [promoLink!], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    let loveButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.setImage((UIImage(named: "love")?.withRenderingMode(.alwaysTemplate)), for: .normal)
        sb.addTarget(self, action: #selector(handleLoveButton(sender:)), for: .touchUpInside)
        sb.tintColor = UIColor.white
        return sb
    }()
    
    var liked: Bool = false
    
    func handleLoveButton(sender: UIButton) {
        if liked {
            loveButton.setImage(UIImage(named: "love")?.withRenderingMode(.alwaysTemplate), for: .normal)
            liked = false
            let alert = UIAlertController(title: "Hủy lưu bài!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            loveButton.setImage(UIImage(named: "favorite-clicked")?.withRenderingMode(.alwaysTemplate), for: .normal)
            liked = true
            let alert = UIAlertController(title: "Lưu thành công!", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    let goButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.setImage((UIImage(named: "go")?.withRenderingMode(.alwaysTemplate)), for: .normal)
        sb.addTarget(self, action: #selector(handleGoButton(sender:)), for: .touchUpInside)
        sb.tintColor = UIColor.white
        return sb
    }()
    
    func handleGoButton(sender: UIButton) {
        let actionSheet = UIAlertController(title: "Bạn muốn mở bằng", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        let browser = UIAlertAction(title: "Trình duyệt", style: .default) { (action) in
//            self.homeController?.showWebView(url: (self.promotion?.link)!)
            let url = URL(string: (self.promotion?.link)!)!
            let sv = SFSafariViewController(url: url)
            self.present(sv, animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
        }
        let app = UIAlertAction(title: "App", style: .default, handler: nil)
        actionSheet.addAction(cancel)
        actionSheet.addAction(browser)
        actionSheet.addAction(app)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func setupViews() {
        view.addSubview(blackView)
        view.addSubview(titleLabel)
        view.addSubview(expiredDay1)
        view.addSubview(expiredDay2)
        view.addSubview(separateView)
        view.addSubview(contentLabel)
        view.addSubview(toolBarBackground)
        view.addSubview(imageView)
        view.addSubview(shareButton)
        view.addSubview(loveButton)
        view.addSubview(goButton)
        // BlueView
        blackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        blackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        let statusHeight = UIApplication.shared.statusBarFrame.height
        blackView.heightAnchor.constraint(equalToConstant: statusHeight).isActive = true
        // TitleLabel
        titleLabel.topAnchor.constraint(equalTo: blackView.bottomAnchor, constant: 50).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        // expiredDay
        expiredDay1.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        expiredDay1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23).isActive = true
        expiredDay2.leftAnchor.constraint(equalTo: expiredDay1.rightAnchor, constant: 8).isActive = true
        expiredDay2.topAnchor.constraint(equalTo: expiredDay1.topAnchor).isActive = true
        // separateView
        separateView.topAnchor.constraint(equalTo: expiredDay1.bottomAnchor, constant: 15).isActive = true
        separateView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        separateView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        separateView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // contentLabel
        contentLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        contentLabel.topAnchor.constraint(equalTo: separateView.bottomAnchor, constant: 17).isActive = true
        

        
        // toolBarBackground
        toolBarBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        toolBarBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toolBarBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        toolBarBackground.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        // imageView
        imageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 14).isActive = true
        imageView.bottomAnchor.constraint(equalTo: toolBarBackground.topAnchor, constant: -34).isActive = true
        
        // shareButton, loveButton, goButton
        shareButton.leftAnchor.constraint(equalTo: toolBarBackground.leftAnchor, constant: 10).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: toolBarBackground.centerYAnchor).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        shareButton.dropShadow()
        //
        goButton.rightAnchor.constraint(equalTo: toolBarBackground.rightAnchor, constant: -10).isActive = true
        goButton.centerYAnchor.constraint(equalTo: toolBarBackground.centerYAnchor).isActive = true
        goButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        //
        loveButton.centerXAnchor.constraint(equalTo: toolBarBackground.centerXAnchor).isActive = true
        loveButton.centerYAnchor.constraint(equalTo: toolBarBackground.centerYAnchor).isActive = true
        loveButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
    }
    
    func handleGesture(sender: UIPanGestureRecognizer) {
        let percentThreshold: CGFloat = 0.3
        
        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        // translate pan gesture states to interacteor calls
        guard let interactor = interactor else {
            print("don't have interactor")
            return
        }
        
        switch sender.state {
        case .began:
            print("began")
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            print("changed")
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            print("cancelled")
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            print("ended")
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
}

