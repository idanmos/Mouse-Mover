//
//  AppDelegate.swift
//  Mouse Mover
//
//  Created by Admin on 17/04/2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let statusMenu = NSMenu(title: "MouseMover")
    private let enableDisableMenuItem: NSMenuItem = NSMenuItem(title: "Enable", action: #selector(toggleMouseMover), keyEquivalent: "")
    private let quitMenuItem: NSMenuItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "")
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.setupStatusItem()
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        if let viewController = NSApplication.shared.keyWindow?.contentViewController as? ViewController {
            viewController.mouseMover.stopMovingMouse()
        }
    }
    
    // MARK: - Handle top bar icon
    
    private func setupStatusItem() {
        if let button = self.statusItem.button {
            button.title = "🖱️"
            // button.image = NSImage(named: "mouse-icon")
            button.action = #selector(showAppWindow)
        }
        
        self.enableDisableMenuItem.target = self
        self.statusMenu.addItem(self.enableDisableMenuItem)
        
        self.quitMenuItem.target = self
        self.statusMenu.addItem(self.quitMenuItem)
        
        self.statusItem.menu = self.statusMenu
    }
    
    @objc private func showAppWindow() {
        NSApplication.shared.keyWindow?.makeKeyAndOrderFront(nil)
    }
    
    @objc private func toggleMouseMover() {
        if let viewController = NSApplication.shared.keyWindow?.contentViewController as? ViewController {
            viewController.startStopButtonClicked()
        }
    }
    
    func updateMenuItemTitle(title: String) {
        self.enableDisableMenuItem.title = title
    }

    @objc private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
    
}
