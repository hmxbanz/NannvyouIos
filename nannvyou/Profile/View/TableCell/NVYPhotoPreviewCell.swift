//
//  NVYPhotoPreviewCell.swift
//  nannvyou
//
//  Created by Danplin on 2018/4/20.
//  Copyright © 2018年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

let NVYPhotoPreviewCellID = "NVYPhotoPreviewCellID";

class NVYPhotoPreviewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    deinit {
        NSLog("NVYPhotoPreviewCell 销毁");
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        };
        self.scrollView.alwaysBounceHorizontal = false;
        self.scrollView.delegate = self;
        
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(doubleTagGestureDetected(gesture:)));
        doubleTap.numberOfTapsRequired = 2;
        self.scrollView .addGestureRecognizer(doubleTap);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
//        self.imageView.center = self.centerOfScrollViewContent(scrollView: self.scrollView);
        self.updateImageViewPosition();
    }
    
    //MARK: Public
    public var imgURL: URL?{
        didSet {
            let path = imgURL?.absoluteString;
            let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: path)
            let viewH = NVY_SCREEN_WIDTH * 9.0 / 16.0;
            self.imageView.frame = CGRect.init(x: 0, y: (self.contentView.bounds.height - viewH) / 2.0, width: NVY_SCREEN_WIDTH, height: viewH);
            self.imageView.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                self.imageView.image = Image;
                self.updateImageViewPosition();
            });
        }
    }
    
    var image: UIImage? {
        didSet{
            self.imageView.image = image;
            self .updateImageViewPosition();
        }
    }
    
    func updateScrollViewInset(insets: UIEdgeInsets) -> Void {
        
    }
    
    func updateImageViewPosition() -> Void {
        let image = self.imageView.image;
        let imageSize = (image != nil) ? image?.size : CGSize.init(width: 1, height: 1);
        let imgViewWidth = NVY_SCREEN_WIDTH;
        let imgViewHeight = (imageSize?.height ?? 0) / (imageSize?.width ?? 1) * imgViewWidth;
        self.scrollView.minimumZoomScale = 1.0; //最小缩放比例
        self.scrollView.maximumZoomScale = 3.0; //最大缩放比例
        self.scrollView.zoomScale = 1.0; //当前缩放比例
        self.scrollView.contentOffset = CGPoint.zero;
        self.imageView.frame = CGRect.init(x: 0, y: 0, width: imgViewWidth, height: imgViewHeight);
        let center = self.centerOfScrollViewContent(scrollView: self.scrollView);
        self.imageView.center = center;
        NSLog("图片中心:\(center)");
    }
    
    //MARK: UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView;
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.imageView.center = self.centerOfScrollViewContent(scrollView: scrollView);
    }
    
    //MARK: Actions
    @objc private func doubleTagGestureDetected(gesture:UITapGestureRecognizer){
        NSLog("handleDoubleTap");
        let touchPoint = gesture.location(in: self);
        if self.scrollView.zoomScale <= 1.0 {
            let scaleX = touchPoint.x + self.scrollView.contentOffset.x;
            let scaleY = touchPoint.y + self.scrollView.contentOffset.y;//需要放大的图片的Y点
            self.scrollView .zoom(to: CGRect.init(x: scaleX, y: scaleY, width: 10, height: 10), animated: true);
        }else{
            self.scrollView.setZoomScale(1.0, animated: true);//还原
        }
    }
    
    /** 计算imageview的center，核心方法之一 */
    func centerOfScrollViewContent(scrollView: UIScrollView) -> CGPoint {
        let size = CGSize.init(width: self.bounds.width - 30, height: self.bounds.height);
        let offsetX = (size.width > scrollView.contentSize.width) ? (size.width - scrollView.contentSize.width) * 0.5 : 0.0; //x偏移
        let offsetY = (size.height > scrollView.contentSize.height) ? (size.height - scrollView.contentSize.height) * 0.5 : 0.0;//y偏移
        let actualCenter = CGPoint.init(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY);
        return actualCenter;
    }
    
    //MARK: Accessor
    private lazy var imageView = {
        () -> UIImageView in
        let view = UIImageView.init();
        view.contentMode = UIViewContentMode.scaleAspectFit;
        self.scrollView.addSubview(view);
        return view;
    }()
}
