//
//  NVYVerticalButton.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/5/29.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYVerticalButton: UIButton {
    
    private var _badgeNumLabel: UILabel?;
    private var _badgeSize = CGFloat(15.0);
    var badgeNum: Int
    {
        didSet
        {
            self.badgeNumLabel?.text = (badgeNum <= 0) ? "" : "\(badgeNum)";
            self.layoutIfNeeded();
        }
    }
    
    var badgeSize: CGFloat {
        get {
            return _badgeSize;
        }
        set {
            _badgeSize = newValue;
            self.layoutIfNeeded();
        }
    }
    
    var showBadgeLabel: Bool
    {
        didSet
        {
            self.badgeNumLabel?.isHidden = !showBadgeLabel;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        badgeNum = Int(arc4random() % 99);
        showBadgeLabel = false;
        super.init(coder: aDecoder);
        self.badgeNumLabel?.text = (badgeNum <= 0) ? "" : "\(badgeNum)";
        self.badgeNumLabel?.isHidden = !showBadgeLabel;
        self.clipsToBounds = false;
    }
    
    var badgeNumLabel: UILabel? {
        get {
            if _badgeNumLabel == nil {
                _badgeNumLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: _badgeSize, height: _badgeSize));
                _badgeNumLabel?.backgroundColor = UIColor.red;
                _badgeNumLabel?.textAlignment = .center;
                _badgeNumLabel?.font = UIFont.systemFont(ofSize: 12);
                _badgeNumLabel?.layer.cornerRadius = (_badgeSize / 2.0);
                _badgeNumLabel?.textColor = UIColor.white;
                _badgeNumLabel?.clipsToBounds = true;
                self.addSubview(_badgeNumLabel!);
            }
            return _badgeNumLabel;
        }
        set {
            _badgeNumLabel = newValue
        }
    }
    
    func badgeStringWidth() -> CGFloat {
        if badgeNum <= 0 {
            return _badgeSize;
        }
        let numStr: NSString = "\(badgeNum)" as NSString;
        let rect = numStr.boundingRect(with: CGSize(width: self.bounds.size.width, height: _badgeSize), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil);
        let width = rect.size.width + 6;
        let result = width < _badgeSize ? _badgeSize : width;
        return result;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        let imgRect = self.imageRect(forContentRect: self.bounds);
        let width = self.badgeStringWidth();
        let labelRect = CGRect.init(x: imgRect.maxX, y: imgRect.minY, width: width, height: _badgeSize);
        self.badgeNumLabel?.frame = labelRect;
    }
    
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let imgWidth  = currentImage?.size.width
        let imgHeight = currentImage?.size.height
        
        let imgX = (frame.size.width - imgWidth!)/2.0
        let imgY = (frame.size.height * 0.6 - imgHeight!)/2.0
        
        return CGRect(x: imgX, y: imgY, width: imgWidth!, height: imgHeight!)
    }

    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
                
        let titleY      = frame.size.height * 0.6
        let titleWidth  = frame.size.width
        let titleHeight = frame.size.height * 0.4
        
        return CGRect(x: 0.0, y: titleY, width: titleWidth, height: titleHeight)
    }
}
