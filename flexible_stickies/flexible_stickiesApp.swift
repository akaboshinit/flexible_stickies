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
                    maxWidth: 800,
                    minHeight: 500,
                    maxHeight: 1000
                )
        }
        .defaultSize(CGSize(width: 400, height: 500))
        .defaultPosition(.topTrailing)
        .windowResizability(.contentSize)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.level = .mainMenu
            window.collectionBehavior = .canJoinAllSpaces
        }
        
        let window = NSApplication.shared.windows.first!
        window.titlebarAppearsTransparent = true
        window.backgroundColor = .white
        window.standardWindowButton(.closeButton)!.isHidden = true
        window.standardWindowButton(.miniaturizeButton)!.isHidden = true
        window.standardWindowButton(.zoomButton)!.isHidden = true
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        // シングルアプリケーションとしたいため、ウィンドウを閉じたらアプリケーションも閉じる仕様とする
        return true
    }
}
