//
//  NVYChatListVC.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/9/17.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

class NVYChatListVC: RCConversationListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "聊天列表"

        //设置需要显示哪些类型的会话
        self.setDisplayConversationTypes([1, 3, 6])
//        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
//            @(ConversationType_DISCUSSION),
//            @(ConversationType_CHATROOM),
//            @(ConversationType_GROUP),
//            @(ConversationType_APPSERVICE),
//            @(ConversationType_SYSTEM)]];
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType(["ConversationType_DISCUSSION", "ConversationType_GROUP", "ConversationType_SYSTEM"])

    }

    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        
        let chatVC = NVYConversationVC()
        chatVC.conversationType = model.conversationType
        chatVC.targetId = model.targetId
        chatVC.title = model.conversationTitle
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }




}
