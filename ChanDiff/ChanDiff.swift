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

        // Invalid channels just get ignored
        let channels = channelStrings.flatMap({ client.findChannel($0) })

        var diff = Set(myChannel.memberList as! [IRCUser])

        for channel in channels {
            diff.intersectInPlace(channel.memberList as! [IRCUser])
        }

        // Sort and format results to print
        let resultChannels = channels.map({ $0.name }).sort().joinWithSeparator(" ")
        let resultUsers = diff.map({ $0.nickname! }).sort().joinWithSeparator(" ")
        let result = String(format:"%@ %@: %@", myChannel.name, resultChannels, resultUsers)
        client.printDebugInformation(result, forCommand: "chandiff")
    }

}
