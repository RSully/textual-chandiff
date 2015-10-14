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
        let myChannel = self.masterController().mainWindow.selectedChannel
        let channelStrings = messageString.componentsSeparatedByString(" ")
        let channels = [client.findChannel(channelStrings[0])]
        // TODO: check if findChannel returns nil otherwise it'll crash

        var diff = Set(myChannel.memberList as! [IRCUser])

        for channel in channels {
            diff.intersectInPlace(channel.memberList as! [IRCUser])
        }

        client.printDebugInformation(diff.map({ $0.nickname! }).sort().description)
    }

}
