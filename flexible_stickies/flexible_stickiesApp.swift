//
//  flexible_stickiesApp.swift
//  flexible_stickies
//
//  Created by redstar16 on 2023/10/23.
//

import SwiftUI

@main
struct flexible_stickiesApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    minWidth: 400,
                    maxWidth: 600,
                    minHeight: 1,
                    maxHeight: 600
                )
        }
        .defaultSize(CGSize(width: 400, height: 500))
        .defaultPosition(.topTrailing)
        .windowResizability(.contentSize)
        .commands {
            CommandMenu("window.level") {
                Button(".floating") {
                    appDelegate.toggleWindowLevel(to: .mainMenu)
                }.keyboardShortcut("f", modifiers: .command)
                Button(".normal") {
                    appDelegate.toggleWindowLevel(to: .normal)
                }.keyboardShortcut("n", modifiers: .command)
            }
            CommandMenu("window.size") {
                Button("Large") {
                    appDelegate.resizeWindow(to: CGSize(width: 400, height: 600))
                }.keyboardShortcut("1", modifiers: .command)
                Button("Small") {
                    appDelegate.resizeWindow(to: CGSize(width: 400, height: 1))
                }.keyboardShortcut("2", modifiers: .command)
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.level = .mainMenu
            window.collectionBehavior = .canJoinAllSpaces
        }
        
        let window = NSApplication.shared.windows.first!
        window.titleVisibility = .hidden
        //        window.toolbar = nil
        window.titlebarAppearsTransparent = true
        window.backgroundColor = .white
        window.standardWindowButton(.closeButton)!.isHidden = true
        window.standardWindowButton(.miniaturizeButton)!.isHidden = true
        window.standardWindowButton(.zoomButton)!.isHidden = true
        
        addButtonToTitleBar()
    }
    
    func toggleWindowLevel(to level: NSWindow.Level) {
        if let window = NSApplication.shared.windows.first {
            window.level = level
            window.collectionBehavior = .canJoinAllSpaces
        }
    }
    
    func resizeWindow(to size: CGSize) {
        if let window = NSApplication.shared.windows.first {
            window.setContentSize(size)
        }
    }
    
    func applicationWillUpdate(_ notification: Notification) {
        DispatchQueue.main.async {
            if let menu = NSApplication.shared.mainMenu {
                for menuItem in menu.items {
                    switch menuItem.title {
                    case "Edit", "File", "Window", "View", "Help":
                        menuItem.isHidden = true
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        // シングルアプリケーションとしたいため、ウィンドウを閉じたらアプリケーションも閉じる仕様とする
        return true
    }
    
    func addButtonToTitleBar() {
        if let window = NSApplication.shared.windows.first {
            let iconImage = NSImage(named: NSImage.shareTemplateName)!
            //            let titleBarButton = MyButton()
            let titleBarButton = NSButton(title: "", image: iconImage, target: self, action: #selector(titleBarButtonClicked(_:)))
            titleBarButton.attributedTitle = NSAttributedString(string: "🕺", attributes: [ NSAttributedString.Key.foregroundColor : NSColor.black])
            titleBarButton.imagePosition = .imageLeading
            titleBarButton.bezelStyle = .texturedRounded
            
            window.standardWindowButton(.closeButton)?.superview?.addSubview(titleBarButton)
            titleBarButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleBarButton.centerYAnchor.constraint(equalTo: window.standardWindowButton(.closeButton)!.centerYAnchor),
                titleBarButton.leadingAnchor.constraint(equalTo: window.standardWindowButton(.closeButton)!.trailingAnchor)
            ])
        }
    }
    @objc
    func titleBarButtonClicked(_ sender: NSButton) {
        if let window = NSApplication.shared.windows.first {
            if (window.frame.size.height < 50){
                window.setContentSize(NSSize(width: 400,height: 600))
            } else{
                window.setContentSize(NSSize(width: 400,height: 1))
            }
        }
    }
}
