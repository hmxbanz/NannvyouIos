//
//  NVYWellcomeVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/24.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYWellcomeVC: UIViewController, UIScrollViewDelegate {

    var screenWidth: CGFloat?
    var screenHeight: CGFloat?
    
    var scrollView: UIScrollView?
    var pageControl: UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenFrame = UIScreen.main.bounds
        screenWidth = screenFrame.width
        screenHeight = screenFrame.height
        
        //第一次开启App，要保存
        UserDefaults.standard.set(true, forKey: "AppStart")
        
        scrollView = initScroll()
        view.addSubview(scrollView!)
        
//        scrollView?.addSubview(initPageControl())

        initViews()
        
    }
    
    func initScroll() -> UIScrollView {
        
        if scrollView == nil {
            scrollView = UIScrollView(frame: view.bounds)
            scrollView?.bounces = false
            scrollView?.delegate = self
            scrollView?.contentSize = CGSize(width: 3.0 * screenWidth!, height: screenHeight!)
        }
        return scrollView!
    }
    
    func initPageControl() -> UIPageControl {
        if pageControl == nil {
            pageControl = UIPageControl(frame: CGRect(x: 0, y: screenHeight! - 50, width: screenWidth!, height: 50))
            pageControl?.currentPage = 0
            pageControl?.currentPageIndicatorTintColor = .red
            pageControl?.numberOfPages = 3
        }
        return pageControl!
    }
    
    func initViews() {
        for i in 1...3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(i - 1) * screenWidth!, y: 0, width: screenWidth!, height: screenHeight!))
            scrollView?.addSubview(pageView)
            
            let pageImgView = UIImageView(frame: pageView.bounds)
            pageView.addSubview(pageImgView)
        
            let img = UIImage(named: "引导图\(i)")
            pageImgView.image = img
            
            if i == 3 {
                let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 80.0, height: 40))
                btn.center = CGPoint(x: screenWidth!/2.0, y: screenHeight! - 80.0)
                btn.addTarget(self, action: #selector(startAction), for: .touchUpInside)
                pageView.addSubview(btn)
                
                btn.layer.cornerRadius = 5.0
                btn.layer.borderColor = UIColor.wz_colorWithHexString(hex: "#ff7da8").cgColor
                btn.layer.borderWidth = 1.0
                btn.setTitle("立即使用", for: .normal)
                btn.setTitleColor(UIColor.wz_colorWithHexString(hex: "#ff7da8"), for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
            }
        }
    }
    
    func startAction() {
        let tabBarController = NVYTabBarController()
        UIApplication.shared.keyWindow!.rootViewController = tabBarController
        tabBarController.selectedIndex = 1
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        if !decelerate {
            let offset = scrollView.contentOffset
            
            let page = Int(offset.x/screenWidth!)
            let cha  = offset.x.truncatingRemainder(dividingBy: screenWidth!)
            
            if screenWidth!/2.0 > cha {
                scrollView.scrollRectToVisible(CGRect(x: CGFloat(page) * screenWidth!, y: 0, width: screenWidth!, height: screenHeight!), animated: false)
            } else {
                scrollView.scrollRectToVisible(CGRect(x: CGFloat(page + 1) * screenWidth!, y: 0, width: screenWidth!, height: screenHeight!), animated: false)
                
            }
        }        
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        let offset = scrollView.contentOffset
        
        let page = Int(offset.x/screenWidth!)
        let cha  = offset.x.truncatingRemainder(dividingBy: screenWidth!)
        
        if screenWidth!/2.0 > cha {
            scrollView.scrollRectToVisible(CGRect(x: CGFloat(page) * screenWidth!, y: 0, width: screenWidth!, height: screenHeight!), animated: false)
        } else {
            scrollView.scrollRectToVisible(CGRect(x: CGFloat(page + 1) * screenWidth!, y: 0, width: screenWidth!, height: screenHeight!), animated: false)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    
    }

}
