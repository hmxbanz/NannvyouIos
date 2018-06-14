
//
//  NVYAlertActionTool.swift
//  nannvyou
//
//  Created by Danplin on 2018/5/28.
//  Copyright © 2018年 MacMin-DLC0001. All rights reserved.
//

import Foundation

func nvy_showAddFriend2BackList(friendID: Int, fromVC: UIViewController, completion: @escaping(_ result: Bool) -> Void) {
    let alertController = UIAlertController(title: "确认加入黑名单?", message: nil, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
    alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
        NVYHomeDataTool.addBlackList(userID: friendID, completion: { (result) in
            completion(result);
        })
    }));
    fromVC.present(alertController, animated: true, completion: nil);
}

func nvy_showDelFriendAlert(friendID: Int, fromVC: UIViewController, completion: @escaping(_ result: Bool) -> Void) {
    let alertController = UIAlertController(title: "确认删除好友?", message: nil, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
    alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (UIAlertAction) in
    NVYProfileDataTool.delectFriend(userID: friendID, completion: { (result) in
            completion(result);
        });
    }));
    fromVC.present(alertController, animated: true, completion: nil);
}
