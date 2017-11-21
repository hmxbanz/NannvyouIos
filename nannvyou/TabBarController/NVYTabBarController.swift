//
//  NVYTabBarController.swift
//  nanvyou
//
//  Created by MacMin-DLC0001 on 2017/5/10.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//


//大体思路和Objectiv-C相同。
//先整体做出个样子，细节问题，以后再管。

import UIKit

class NVYTabBarController: UITabBarController ,UITabBarControllerDelegate{

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    let tabBarWidth: CGFloat = 64
    let tabBarHeight: CGFloat = 49
    let tabBarViewHeight: CGFloat = 60
    
    var tabButtons = [UIButton]()
    var imgArr = [#imageLiteral(resourceName: "tab_search"), #imageLiteral(resourceName: "tab_logo"), #imageLiteral(resourceName: "tab_me")];
    var imgSelArr = [#imageLiteral(resourceName: "tab_search_hover"), #imageLiteral(resourceName: "tab_logo_hover"), #imageLiteral(resourceName: "tab_me_hover")]
    let titles = ["搜索", " ", "我的"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        self.view.backgroundColor = UIColor.white
        
        self.delegate = self;
        initControllers()
    }
    
    func initControllers() -> Void
    {
        let searchVC  = NVYSearchVC()
        let homeVC    = NVYMainHomeVC()
        let profileVC = NVYProfileVC()
        
        var viewArr = [searchVC, homeVC, profileVC]
        
        var viewCtlArr = [AnyObject]()
        for index in 0..<viewArr.count
        {
            let vc = viewArr[index]
            
            let navController = NVYNavigationController(rootViewController: vc)
            viewCtlArr.append(navController)
            
            var norImg: UIImage = imgArr[index]
            norImg = norImg.withRenderingMode(.alwaysOriginal)
            
            var selImg: UIImage = imgSelArr[index]
            selImg = selImg.withRenderingMode(.alwaysOriginal)
            
            
            vc.tabBarItem.image = norImg
            vc.tabBarItem.selectedImage = selImg
            if index != 1 {
                vc.tabBarItem.title = titles[index]
            }
            
            // set the text color for unselected state
            // 普通状态下的文字属性
            let normalAttrs = [NSBackgroundColorAttributeName : UIColor.black]
            
            // set the text color for selected state
            // 选中状态下的文字属性
            let selectedAttrs = [NSForegroundColorAttributeName : UIColor.wz_colorWithHexString(hex: "#ff7da8")];
            
            // 设置文字属性
            navController.tabBarItem.setTitleTextAttributes(normalAttrs, for: .normal)
            navController.tabBarItem.setTitleTextAttributes(selectedAttrs, for: .selected)

        }
        
        viewControllers = viewCtlArr as? [UIViewController]
    }
    
    //    MARK:UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = self.viewControllers?.index(of: viewController);
        if index == 2 {
            let logined = NVYUserModel.isLogined();
            if !logined {
                let loginVC = NVYLoginVC();
                loginVC.presentMode = true;
                let loginNav = NVYNavigationController.init(rootViewController: loginVC);
                let curVC:NVYNavigationController? = self.selectedViewController as? NVYNavigationController;
                curVC?.present(loginNav, animated: true, completion: nil);
                loginVC.loginSuccess = { () -> Void in
                    curVC?.dismiss(animated: true, completion: nil);
                }
            }
            return logined;
        }
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

/*func customTabBar() -> Void
 {
 let tabBarOffsetX = screenWidth!/3
 let tabBarX = tabBarOffsetX/2 - tabBarWidth/2
 //        let tabBarY = tabBarViewHeight/2 - tabBarHeight/2
 let tabBarView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth!, height: tabBarViewHeight))
 tabBarView.backgroundColor = UIColor.white
 self.tabBar.addSubview(tabBarView)
 
 for index in 0..<imgArr.count
 {
 let tabBar_X = (CGFloat)(index) * tabBarOffsetX
 
 var btn = UIButton()
 if index == 1 {
 btn = UIButton(frame: CGRect(x: (CGFloat)(tabBarX + tabBar_X), y: 0.0, width: tabBarWidth, height: tabBarHeight))
 } else {
 btn = NVYVerticalButton(frame: CGRect(x: (CGFloat)(tabBarX + tabBar_X), y: 0.0, width: tabBarWidth, height: tabBarHeight))
 btn.setTitle(titles[index], for: UIControlState.normal)
 btn.setTitleColor(UIColor.black, for: UIControlState.normal)
 btn.titleLabel?.textAlignment = NSTextAlignment.center
 btn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
 }
 if(index == 0) {
 btn.setImage(imgSelArr[index], for: UIControlState.normal)
 }else{
 btn.setImage(imgArr[index], for: UIControlState.normal)
 }
 
 btn.tag = index + 100
 btn.addTarget(self, action: #selector(tabAction(obj:)), for: UIControlEvents.touchUpInside) //Swift 3.0 之前是用Selector()
 
 tabBarView.addSubview(btn)
 tabButtons.append(btn)
 }
 
 }
 
 func tabAction(obj: UIButton) -> Void
 {
 let indexSel = obj.tag - 100
 self.selectedIndex = indexSel
 for index in 0..<tabButtons.count {
 
 if(index == indexSel) {
 
 tabButtons[indexSel].setImage(imgSelArr[index], for: UIControlState.normal)
 }else{
 tabButtons[index].setImage(imgArr[index], for: UIControlState.normal)
 }
 }
 }*/
