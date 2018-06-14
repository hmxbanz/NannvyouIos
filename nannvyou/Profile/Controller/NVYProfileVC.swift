//
//  NVYProfileVC.swift
//  nanvyou
//
//  Created by MacMin-DLC0001 on 2017/5/10.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

class NVYProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RCIMReceiveMessageDelegate {
    
    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var profileTable: UITableView?

    let cellTitles = ["个人资料", "择偶条件", "我的相册", "谁看了我", "我的收藏", "会员记录"]

    let cellImg = [#imageLiteral(resourceName: "icon_modify"), #imageLiteral(resourceName: "icon_condition"), #imageLiteral(resourceName: "icon_album"), #imageLiteral(resourceName: "icon_eye"), #imageLiteral(resourceName: "icon_favor"), #imageLiteral(resourceName: "icon_order")]
    
    var selfLoadHead: NVYLoadHead?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false
        
        initTableHead()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
//        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "个人中心"
        
        view.backgroundColor = UIColor.white
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        addUserLoginNotification();
        
        profileTable = initProfileTable()
        view.addSubview(profileTable!)
        if NVYUserModel.isLogined() {
            loadUserInfo();
        }
        
    }
    
    deinit {
        removeUserLoginNotification();
    }
    
    func loadUserInfo() -> Void {
        NVYProfileDataTool.getUserInfo(completion: { (result) in
            if result {
                print("获取用户资料成功");
            }
        })
    }
    
    func initTableHead() {
        
        if NVYUserModel.isLogined() {
            signedHead()
        } else {
            unSignHead()
        }
    }
    
    //已登录的head
    func signedHead() {
        
//        let heightRate = CGFloat(220.0/667.0)
        let headHeight = 220.0//heightRate * screenHeight!
        
        let loadHead = Bundle.main.loadNibNamed("NVYLoadHead", owner: nil, options: nil)?.first as! NVYLoadHead
        
        loadHead.frame = CGRect(x: 0.0, y: 0.0, width: Double(screenWidth!), height: headHeight)
        profileTable?.tableHeaderView = loadHead
        
        loadHead.updateHead()
        
        selfLoadHead = loadHead
        
        loadHead.headSettingAction = { () -> Void in
            let vc = NVYSettingVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        loadHead.headUserIconAction = { (UIButton) -> Void in
            self.takePhoto()
        }
        
        //个人主页
        loadHead.headHomeAction = { () -> Void in
            let vc = NVYUserPageVC()
            vc.isSelf = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        //聊天
        loadHead.headMsgAction = { () -> Void in
//            HUD.flash(.label("功能开发中，敬请期待！"), onView: self.view, delay: 1.0, completion: nil)
            let vc = NVYChatListVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        RCIM.shared().receiveMessageDelegate = self;
        
        loadHead.headFriendAction = { () -> Void in
            let vc = NVYMyFriendVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        updateUnreadInfo();
        updateSystemMsgUnreadInfo();
        
        loadHead.headActivityAction = { () -> Void in
            let vc = NVYPublishConditionVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //未登录时的头部
    func unSignHead() {
        
        let unloadHead: NVYUnloadHead = Bundle.main.loadNibNamed("NVYUnloadHead", owner: nil, options: nil)?.first as! NVYUnloadHead
        unloadHead.frame = CGRect(x: 0, y: 0, width: screenWidth!, height: 140.0)
        profileTable?.tableHeaderView = unloadHead
        
        unloadHead.loginEvent = { () -> Void in
            
            self.gotoLogin()
        }
    }
    
    func gotoLogin() {
        
        let loginVC = NVYLoginVC()
        navigationController?.pushViewController(loginVC, animated: true)
        
        loginVC.loginSuccess = { () -> Void in
            self.signedHead();
            self.loadUserInfo();
        }
    }
    
    func takePhoto() {
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        actionsheet.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            
            self.takePhoto(type: 0)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "从相册获取", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
        
            self.takePhoto(type: 1)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) in }))
        
        self.present(actionsheet, animated: true, completion: nil)
    }
    
    func initProfileTable() -> UITableView {
        if profileTable == nil {
            let frame = CGRect(x: 0, y: 0, width: screenWidth!, height: screenHeight! - 0);//CGRect(x: 0, y: -20, width: screenWidth!, height: screenHeight! - 29.0)
            profileTable = UITableView(frame: frame, style: UITableViewStyle.plain)
            profileTable?.rowHeight = 50
            profileTable?.delegate = self
            profileTable?.dataSource = self
            profileTable?.backgroundColor = UIColor.groupTableViewBackground
            profileTable?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
            profileTable?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "normalCell")
            if #available(iOS 11.0, *) {
                profileTable?.contentInsetAdjustmentBehavior = .never
            } else {
                // Fallback on earlier versions
                self.automaticallyAdjustsScrollViewInsets = false;
            };
        }
        return profileTable!
    }
    
    func takePhoto(type: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        if type == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
            } else {
                let alert = UIAlertController(title: "您的设备不支持照相机功能", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
                
                }))
                alert.show(self, sender: nil)
            }
        } else {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
            }
        }
    
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let type = info[UIImagePickerControllerMediaType] as! String
        
        //当选择的类型是图片
        if (type == "public.image") {
            
            let image = info[UIImagePickerControllerEditedImage] as! UIImage

            NVYProfileDataTool.uploadUserIcon(image: image, completion: { (result) in
                
                if result {
                    HUD.flash(.label("上传成功"), delay: 1.0)
                    NVYProfileDataTool.getUserInfo(completion: { (result) in
                        if result {
                            self.selfLoadHead?.updateHead()
                        }
                    })
                } else {
                    HUD.flash(.label("上传失败"), delay: 1.0)
                }
            })
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
        HUD.flash(.label("已取消"), delay: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //MARK:RCIMReceiveMessageDelegate 融云相关方法
    //更新消息标记
    private func updateUnreadInfo(){
        let unreadCount = NVYProfileDataTool.unreadMsgTotalCount();
        selfLoadHead?.chatBtn.showBadgeLabel = (unreadCount > 0);
        selfLoadHead?.chatBtn.badgeNum = unreadCount;
    }
    
    //更新好友按钮标记
    private func updateSystemMsgUnreadInfo () {
        let systemCount = NVYProfileDataTool.unreadSystemMsgCount();
        selfLoadHead?.friendBtn.badgeSize = 10;
        selfLoadHead?.friendBtn.badgeNum = 0; //系统未读信息不需显示数量。只显示红点即可
        selfLoadHead?.friendBtn.showBadgeLabel = (systemCount > 0);
        NVYProfileDataTool.getUnreadMsgCountFromServer(type: 2) { (count) in
            print("获取到服务器系统未读信息数:\(count)");
        }
    }
    
    //收到消息代理
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
        updateUnreadInfo();
        if message.conversationType == .ConversationType_SYSTEM {
            updateSystemMsgUnreadInfo();
        }
    }
    
    
    func userLoginNotification(notify:Notification) -> Void {
        //用户登录完成的通知
        self.signedHead();
        self.loadUserInfo();
    }
    
    func addUserLoginNotification() -> Void {
        let notifyName = Notification.Name.init(kNVYUserDidLogin);
        NotificationCenter.default.addObserver(self, selector: #selector(NVYProfileVC.userLoginNotification), name: notifyName, object: nil);
    }
    
    func removeUserLoginNotification() -> Void {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(kNVYUserDidLogin), object: nil);
    }
}

extension NVYProfileVC {
    
    ///MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth!, height: 10.0))
        view.backgroundColor = UIColor.clear;//UIColor.wz_colorWithHexString(hex: "EFEFF4"); //UIColor.groupTableViewBackground
        return view
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section != 1 {
//            return 10.0
//        }
//        return 0.0
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth!, height: 10.0))
//        view.backgroundColor = UIColor.wz_colorWithHexString(hex: "EFEFF4"); //UIColor.groupTableViewBackground
//        return view
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "normalCell")!
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        if indexPath.section == 0 {
            cell.textLabel?.text = cellTitles[indexPath.row]
            cell.textLabel?.textColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImg[indexPath.row])
            cell.imageView?.image = img
        } else {
            cell.textLabel?.text = cellTitles[indexPath.row + 3]
            cell.textLabel?.textColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
            let img = UIImage.wz_changeImageTintColor(tintColor: UIColor.wz_colorWithHexString(hex: "#ff7da8"), image: cellImg[indexPath.row + 3])
            cell.imageView?.image = img
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 0://个人资料
                let personInfoVC = NVYPersonInfoVC()
                self.navigationController?.pushViewController(personInfoVC, animated: true)
                break
                
            case 1://择偶条件
                let conditionVC = NVYPerConditionVC()
                self.navigationController?.pushViewController(conditionVC, animated: true)
                break
                
            default://相册
                let layout2 = UICollectionViewFlowLayout()
                layout2.scrollDirection = UICollectionViewScrollDirection.vertical;
                
                let myPhotos = NVYMyPhotosVC(collectionViewLayout: layout2)
                self.navigationController?.pushViewController(myPhotos, animated: true)
                break
                
            }
        } else {
            
            switch indexPath.row {
            case 0://谁看了我
                let personInfoVC = NVYVisitVC()
                self.navigationController?.pushViewController(personInfoVC, animated: true)
                break
                
            case 1://我的收藏
                let conditionVC = NVYMyCollectionVC()
                self.navigationController?.pushViewController(conditionVC, animated: true)
                break
                
            default://消费记录
                let chargeVC = NVYMyChargeVC()
                self.navigationController?.pushViewController(chargeVC, animated: true)
                break
                
            }
        }
    }
}

