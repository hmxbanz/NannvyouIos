//
//  NVYReportVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/8/7.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit
import PKHUD

class NVYReportVC: UIViewController {

    var reportID: Int = 0
    
    @IBOutlet weak var contentTV: UITextView!
    
    var reportTitle: String?
    
    @IBOutlet weak var reportBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "举报"

        contentTV.layer.borderColor  = UIColor.groupTableViewBackground.cgColor
        contentTV.layer.borderWidth  = 1
        contentTV.layer.cornerRadius = 5.0
        
        reportBtn.layer.cornerRadius = 5.0
    }
    
    @IBAction func selectTitle(_ sender: UIButton) {
        
        reportTitle = sender.titleLabel?.text
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func reportBtnAction(_ sender: UIButton) {
        
        if reportTitle == nil {
            HUD.flash(.label("请选择举报类型"), delay: 1.0)
            return;
        }
        
        if contentTV.text == "" {
            HUD.flash(.label("请输入举报内容"), delay: 1.0)
            return;
        }
        
        NVYHTTPTool.postMethod(url: "\(kBaseURL)/Home/Report",
                 params: ["title" : reportTitle!,
                          "content" : contentTV.text,
                          "objectUserInfoID" : "\(reportID)"]) { (DataResponse) in
                
                            print("举报 = %@", DataResponse.result.value!)
                            
                            let responseDict = DataResponse.result.value! as! NSDictionary
                            
                            let state = responseDict["state"] as! Int
                            if state == 1 {
                                HUD.flash(.labeledSuccess(title: "举报成功", subtitle: nil), delay: 1.0)
                            } else {
                                HUD.flash(.labeledError(title: "举报失败", subtitle: nil), delay: 1.0)
                            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
