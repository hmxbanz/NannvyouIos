//
//  NVYMyPhotosVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/9.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

/// 我的相册
class NVYMyPhotosVC: UICollectionViewController, UICollectionViewDelegateFlowLayout
{

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var albums: Array<NVYMyAlbumModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        navigationItem.title = "相册"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UINib.init(nibName: "NVYHomeCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.white

        setNavRightBtn()
        
        albums = Array()
        
        NVYProfileDataTool.getUserAlbum { (Albums) in
            self.albums = Albums
            self.collectionView?.reloadData()
        }

    }
    
    func setNavRightBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "上传", style: .plain, target: self, action: #selector(rightBtnAction))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white;
    }
    
    func rightBtnAction() {
        
        let vc = NVYUploadPhotoVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.albums?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NVYHomeCell
        
        if (albums?.count)! > 0 {
            
            let model = albums![indexPath.row]
            
            let imgStr = "\(kBaseURL)\(model.PhotoSmall ?? "")"
            let imgURL = NSURL(string: imgStr)
            let imgResource = ImageResource(downloadURL: imgURL! as URL, cacheKey: imgStr)
            cell?.userIcon?.kf.setImage(with: imgResource, placeholder: Image(named: "icon_head"), options: nil, progressBlock: nil, completionHandler: { (Image, NSError, CacheType, URL) in
                
            })
            
            cell?.userNameLabe.text = "\(model.AlbumName ?? "")"
            
        } 
        
        return cell!
    }

    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (self.albums?.count)! > 2 {
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
        
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical;
        let model = albums![indexPath.row];
        let vc = NVYMyAlbumDetailVC(collectionViewLayout: layout)
        vc.albumModel = model;
        vc.albumType = indexPath.row + 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
