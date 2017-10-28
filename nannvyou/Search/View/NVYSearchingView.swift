//
//  NVYSearchingView.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/4.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

//性别的block 1代表男 2代表女
typealias SearchSexBlock    = (_ btnTag: NSInteger) -> Void
//婚姻状态block 1代表未婚 2代表离异
typealias SearchStatusBlock = (_ btnTag: NSInteger) -> Void
typealias SearchAgeBlock    = () -> Void
typealias SearchCityBlock   = () -> Void
typealias SearchBtnBlock    = () -> Void

class NVYSearchingView: UIView {

    @IBOutlet weak var boyButton: UIButton!
    
    @IBOutlet weak var girlButton: UIButton!
    
    var currentSexBtn: UIButton!
    
    @IBOutlet weak var singleButton: UIButton!
    
    @IBOutlet weak var divorceButton: UIButton!
    
    var currentStatusBtn: UIButton!
    
    @IBOutlet weak var ageButton: UIButton!
    
    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    //block
    var sexBlock: SearchSexBlock?
    var statusBlcok: SearchStatusBlock?
    var ageBlock: SearchAgeBlock?
    var cityBlock: SearchCityBlock?
    var searchBlock: SearchBtnBlock?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        currentSexBtn = boyButton
        currentSexBtn.isSelected = true
        
        currentStatusBtn = singleButton
        currentStatusBtn.isSelected = true
        
        ageButton.layer.cornerRadius = 5.0
        ageButton.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")
        
        cityButton.layer.cornerRadius = 5.0
        cityButton.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")
        
        searchButton.layer.cornerRadius = 5.0
        searchButton.backgroundColor = UIColor.wz_colorWithHexString(hex: "#5bc0de")
    }
    
    
    @IBAction func sexButtonAction(_ sender: UIButton) {
        
        if currentSexBtn.tag == sender.tag {
            
        } else {
            currentSexBtn.isSelected = false
            currentSexBtn = sender
            currentSexBtn.isSelected = true
        }
        
        if sexBlock != nil {
            sexBlock!(sender.tag - 1000)
        }
    }
    
    @IBAction func statusButton(_ sender: UIButton) {
        
        if currentStatusBtn.tag == sender.tag {
            
        } else {
            currentStatusBtn.isSelected = false
            currentStatusBtn = sender
            currentStatusBtn.isSelected = true
        }
        
        if statusBlcok != nil {
            statusBlcok!(sender.tag - 2000)
        }
    }
    
    @IBAction func ageAction(_ sender: UIButton) {
        
        if ageBlock != nil {
            ageBlock!()
        }
    }
    
    @IBAction func cityAction(_ sender: UIButton) {
        
        if cityBlock != nil {
            cityBlock!()
        }
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        
        if searchBlock != nil {
            searchBlock!()
        }
    }
}
