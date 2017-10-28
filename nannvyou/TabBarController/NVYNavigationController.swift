//
//  NVYNavigationController.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/13.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.classForCoder == NVYNavigationController.classForCoder() {
            setUpNavigationBarAppearance()
            
            navigationItem.leftBarButtonItem?.tintColor = UIColor.white
            navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        }

    }
    
    /**
     *  设置navigationBar样式
     */
    func setUpNavigationBarAppearance() {
        
        // 1.取出设置主题的对象
        let navigationBar = UINavigationBar.appearance()
        
        // 2.设置导航栏的背景图片
//        let backgroundImage = UIImage()
        var textAttributes = NSDictionary()
        
        textAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0),
                          NSForegroundColorAttributeName : UIColor.white]
        
        navigationBar.barTintColor = UIColor.wz_colorWithHexString(hex: "#ff7da8")
        //  translucent = NO -> 控制器计算尺寸时，不需要+64像素
        navigationBar.isTranslucent = false;
        
        //    [navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        navigationBar.titleTextAttributes = textAttributes as? [String : Any];
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            btn.setImage(#imageLiteral(resourceName: "arrow_left"), for: .normal)
            btn.addTarget(self, action: #selector(popself), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
            
            self.viewControllers.first?.navigationController?.interactivePopGestureRecognizer?.delegate = (self as! UIGestureRecognizerDelegate)
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func popself() {
        self.popViewController(animated: true)
    }
    
    /**
     *  状态栏样式
     */
    override var preferredStatusBarStyle: UIStatusBarStyle{get { return.lightContent}}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
