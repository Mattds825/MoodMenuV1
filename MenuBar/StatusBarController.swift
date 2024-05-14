//
//  StatusBarController.swift
//  MoodMenuV1
//
//  Created by Matt Da Silva on 14/05/2024.
//

import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    private(set) var statusItem: NSStatusItem
    private(set) var popover: NSPopover
    
    init(_ popover: NSPopover){
        self.popover = popover
        statusBar = .init()
        
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "house", accessibilityDescription: nil)
            button.action = #selector(showApp(sender:))
            button.target = self
        }
    }
    
    @objc
    func showApp(sender: AnyObject){
        if popover.isShown {
            popover.performClose(nil)
        }else{
            popover.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
        }
    }
}
