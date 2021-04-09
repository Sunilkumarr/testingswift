//
//  ViewController.swift
//  testingswift
//
//  Created by apple on 17/03/21.
//

import UIKit
import ApplozicCore

class ViewController: UIViewController, ApplozicUpdatesDelegate {
    func onMessageReceived(_ alMessage: ALMessage!) {
        print("MQTT onMessageReceived new message ", alMessage.message);

    }

    func onMessageSent(_ alMessage: ALMessage!) {
        print("MQTT onMessageReceived new message ", alMessage.message);
    }

    func onUserDetailsUpdate(_ userDetail: ALUserDetail!) {

    }

    func onMessageDelivered(_ message: ALMessage!) {

    }

    func onMessageDeleted(_ messageKey: String!) {

    }

    func onMessageDeliveredAndRead(_ message: ALMessage!, withUserId userId: String!) {

    }

    func onConversationDelete(_ userId: String!, withGroupId groupId: NSNumber!) {

    }

    func conversationRead(byCurrentUser userId: String!, withGroupId groupId: NSNumber!) {

    }

    func onUpdateTypingStatus(_ userId: String!, status: Bool) {

    }

    func onUpdateLastSeen(atStatus alUserDetail: ALUserDetail!) {

    }

    func onUserBlockedOrUnBlocked(_ userId: String!, andBlockFlag flag: Bool) {

    }

    func onChannelUpdated(_ channel: ALChannel!) {

    }

    func onAllMessagesRead(_ userId: String!) {

    }

    func onMqttConnectionClosed() {

    }

    func onMqttConnected() {
        print("MQTT connected");

    }

    func onUserMuteStatus(_ userDetail: ALUserDetail!) {

    }

    func onChannelMute(_ channelKey: NSNumber!) {

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let alUser : ALUser =  ALUser()
        alUser.userId = "xyz"     // NOTE : +,*,? are not allowed chars in userId.
        alUser.displayName = "xyz"     // User's Display Name
        alUser.password = "xyz" //User password

        //Saving these details
        ALUserDefaultsHandler.setUserId(alUser.userId)
        ALUserDefaultsHandler.setEmailId(alUser.email)
        ALUserDefaultsHandler.setDisplayName(alUser.displayName)
        ALUserDefaultsHandler.setPassword(alUser.password)
        ALUserDefaultsHandler.setUserAuthenticationTypeId(Int16(APPLOZIC.rawValue))

        let client = ApplozicClient.init(applicationKey: "applozic-sample-app", with: self)

        if (ALUserDefaultsHandler.isLoggedIn()) {
            print("USer is aleady login in cocopods SPM");
            client?.getLatestMessages(false, withCompletionHandler: { messageList, error in
                if error == nil {

                    client?.subscribeToConversation()

                }
                print("The messages already login geeting count %@", messageList?.count as Any)
            })
        } else {

            client?.loginUser(alUser, withCompletion: { (respose, error) in

                if (error == nil) {

                    client?.getLatestMessages(false, withCompletionHandler: { messageList, error in
                        if error == nil {

                        }

                        print("The messages are now in login call  %@", messageList?.count as Any)
                    })
                    print("@@Success login ");
                }

            })
        }

    }

}

