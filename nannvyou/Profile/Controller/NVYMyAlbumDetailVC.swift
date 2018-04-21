//
//  NVYMyAlbumDetailVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/11.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "DetailCell"

class NVYMyAlbumDetailVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var albumType: Int = 0
    
    var albumModel: NVYMyAlbumModel?;
    
    var dataArr: Array<NVYAlbumDetailModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        dataArr = Array()
        
        navigationItem.title = albumModel?.AlbumName ?? "";//"专辑图片"

        self.collectionView!.register(UINib.init(nibName: "NVYHomeCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.groupTableViewBackground
        
        let albumID = self.albumModel?.AlbumID ?? 0;//albumType
        NVYProfileDataTool.getUserPhotos(albumID: albumID) { (Photos) in
            self.dataArr = Photos
            self.collectionView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataArr?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NVYHomeCell
        
        if (dataArr?.count)! > 0 {
            
                let model = dataArr![indexPath.row]
                
                let imgStr = "\(kBaseURL)\(model.PhotoSmall ?? "")"
                let imgURL = NSURL(string: imgStr)
                let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
                cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                    
                })
                
                cell?.userNameLabe.text = "\(model.PhotoInfo ?? "")"
            
        }
        
        return cell!
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (self.dataArr?.count)! > 2 {
            let width  = (screenWidth! - 40)/3.0
            let height = width + 20.0
            
            return CGSize(width: width, height: height)
        } else {
            let width  = 100.0
            let height = width + 20.0
            
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewVC = NVYPhotoPreviewVC();
        var pathList: Array<String>? = Array.init();
        for model in self.dataArr! {
            var path = model.PhotoBig ?? (model.PhotoSmall ?? "");
            path = "\(kBaseURL)\(path)";
            pathList?.append(path);
        }
        previewVC.title = self.navigationItem.title;
        previewVC.pathList = pathList;
        previewVC.index = indexPath.item;
        navigationController?.pushViewController(previewVC, animated: true);
    }

}
