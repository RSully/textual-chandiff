//
//  ChanDiff.swift
//  ChanDiff
//
//  Created by Ryan Sullivan on 10/14/15.
//  Copyright © 2015 Ryan Sullivan. All rights reserved.
//

import Foundation

class ChanDiff: NSObject, THOPluginProtocol
{

    var subscribedUserInputCommands: [AnyObject] {
        return ["chandiff"]
    }

    func userInputCommandInvokedOnClient(client: IRCClient!, commandString: String!, messageString: String!) {
        let channels = commandString.componentsSeparatedByString(" ")
        let channel1 = client.findChannel(channels[0])
        let channel2 = self.masterController().mainWindow.selectedChannel

        let diff = channel1.memberList.map({
            channel2.findMember($0.nickname) == nil
        })
    }

}
