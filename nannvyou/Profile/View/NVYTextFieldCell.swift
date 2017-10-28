//
//  NVYTextFieldCell.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/7/4.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYTextFieldCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    var path: NSIndexPath?
    
    weak var delegate: NVYTextFieldCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self

    }
    
    //MARK: - UITextFieldDelegate
    //swift的这个方法好特别，居然要拼接后才可以获得最终值。
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
//        if delegate != nil {
//            delegate?.finishTFEdit(cell: self, text: textField.text! + string, path: path!)
//        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if delegate != nil {
            delegate?.finishTFEdit(cell: self, text: textField.text!, path: path!)
        }
        
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
}

protocol NVYTextFieldCellDelegate: NSObjectProtocol {
    
    func finishTFEdit(cell: NVYTextFieldCell, text: String, path: NSIndexPath)
    
}
