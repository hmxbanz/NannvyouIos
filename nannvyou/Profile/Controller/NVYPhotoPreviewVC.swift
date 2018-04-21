//
//  NVYPhotoPreviewVC.swift
//  nannvyou
//
//  Created by Danplin on 2018/4/20.
//  Copyright © 2018年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

let kItemPad: CGFloat = 30;

class NVYPhotoPreviewVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var pathList: Array<String>?;
    var index = 0;
    var itemSize = CGSize.zero;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.title = self.title ?? "";//"专辑图片"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.scrollToPage(page: self.index);
    }
    
    //MARK: Private
    private func scrollToPage(page: NSInteger) -> Void {
        let listCount = self.pathList?.count ?? 0;
        if page < listCount {
            let indexPath = IndexPath.init(item: page, section: 0);
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true);
            self.index = page;
        }
    }
    
    //MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.pathList?.count ?? 0;
        return count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        NSLog("Item Size = \(self.itemSize)");
        return self.itemSize;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NVYPhotoPreviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NVYPhotoPreviewCellID, for: indexPath) as! NVYPhotoPreviewCell;
        let path = self.pathList![indexPath.item];
        let imgURL = URL(string: path);
        let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: path)
        let tmpImageView = UIImageView.init();
        tmpImageView.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
            cell.image = Image;
        });
        
//        cell.imgURL = imgURL;
//        let red = CGFloat(arc4random() % 255) / 255.0;
//        let g = CGFloat(arc4random() % 255) / 255.0;
//        let b = CGFloat(arc4random() % 255) / 255.0;
//        cell.backgroundColor = UIColor.init(red: red, green: g, blue: b, alpha: 1.0);
        cell.backgroundColor = UIColor.clear;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        NSLog("cellSize:\(cell.frame), contentSize:\(cell.contentView.frame)");
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset;
        let pageSize = self.itemSize.width;
        let page = lround(Double(offset.x / pageSize));
        if page != self.index {
            scrollViewEndScroll(scrollView: scrollView);
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll(scrollView: scrollView);
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll(scrollView: scrollView);
    }
    
    private func scrollViewEndScroll(scrollView: UIScrollView) -> Void {
        let offset = scrollView.contentOffset;
        let pageSize = self.itemSize.width;
        let page = lround(Double(offset.x / pageSize));
        self.index = page;
        NSLog("Page:\(page)");
    }
    
    
    //MARK: Accessor
    private lazy var collectionView: UICollectionView = {
        () -> UICollectionView in
        let screenSize = UIScreen.main.bounds.size;
        let flowLayout = UICollectionViewFlowLayout.init();
        flowLayout.scrollDirection = .horizontal;
//        flowLayout.itemSize = self.itemSize;
        let viewH = NVY_SCREEN_HEIGHT - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.height ?? 0);
        let frame = CGRect.init(x: 0, y: 0, width: screenSize.width + kItemPad, height: viewH);
        self.itemSize = frame.size;
        let tmpView = UICollectionView.init(frame: frame, collectionViewLayout: flowLayout);
        tmpView.backgroundColor = .black;
        tmpView.isPagingEnabled = true;
        tmpView.showsHorizontalScrollIndicator = false;
        tmpView.bounces = true;
//        if #available(iOS 11.0, *) {
////            tmpView.contentInsetAdjustmentBehavior = .never;
//        }else{
//
//        }
        var nib = UINib.init(nibName: "NVYPhotoPreviewCell", bundle: nil);
        tmpView.register(nib, forCellWithReuseIdentifier: NVYPhotoPreviewCellID);
        tmpView.delegate = self;
        tmpView.dataSource = self;
        self.view.addSubview(tmpView);
        tmpView.snp.makeConstraints({ (make) in
            make.top.left.equalTo(0);
            make.height.equalTo(self.view);
            make.width.equalTo(self.view).offset(kItemPad);
        })
        
        return tmpView;
    }();
    
    
}
