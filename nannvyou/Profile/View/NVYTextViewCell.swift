//
//  NVYTextViewCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/6.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYTextViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: NVYTextViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        textView.layer.borderColor = UIColor.wz_colorWithHexString(hex: "#5bc0de").cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5.0
        textView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.textViewCellBeginEdit(cell: self);
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
//        if delegate != nil {
//            delegate?.finishTVEdit(cell: self, text: textView.text + text)
//        }
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if delegate != nil {
            delegate?.finishTVEdit(cell: self, text: textView.text)
        }
        
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}

protocol NVYTextViewCellDelegate: NSObjectProtocol {
    
    func finishTVEdit(cell: NVYTextViewCell, text: String);
    
    func textViewCellBeginEdit(cell: NVYTextViewCell);
}
