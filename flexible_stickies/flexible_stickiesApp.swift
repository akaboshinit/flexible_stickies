//
//  flexible_stickiesApp.swift
//  flexible_stickies
//
//  Created by redstar16 on 2023/10/23.
//

import SwiftUI


let minWidth:CGFloat = 400
let maxWidth:CGFloat = 400
let minHeight:CGFloat = 1
let maxHeight:CGFloat = 600

@main
struct flexible_stickiesApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.openWindow) var openWindow
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    minWidth: minWidth,
                    maxWidth: maxWidth,
                    minHeight: minHeight,
                    maxHeight: maxHeight
                ).toolbar(content: {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.automatic) {
                        Button(action: {
                            toggleWindowSize()
                        }, label: {
                            Text("📦")
                        })
                        .buttonStyle(.plain)
                    }
                    ToolbarItemGroup(placement: ToolbarItemPlacement.automatic) {
                        Button(action: {
                            openWindow(id: "other")
                            if let window = NSApplication.shared.windows.last {
                                initWindowSetting(window)
                            }
                        }, label: {
                            Text("👉")
                        })
                        .buttonStyle(.plain)
                    }
                })
        }
        .defaultSize(CGSize(width: maxWidth, height: maxHeight))
        .defaultPosition(.topLeading)
        .windowResizability(.contentSize)
        
        
        WindowGroup(id:"other") {
            ContentView()
                .frame(
                    minWidth: minWidth,
                    maxWidth: maxWidth,
                    minHeight: minHeight,
                    maxHeight: maxHeight
                ).toolbar(content: {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.automatic) {
                        Button(action: {
                            toggleWindowSize()
                        }, label: {
                            Text("📦")
                        })
                        .buttonStyle(.plain)
                    }
                    ToolbarItemGroup(placement: ToolbarItemPlacement.automatic) {
                        Button(action: {
                            openWindow(id: "other")
                            if let window = NSApplication.shared.windows.last {
                                initWindowSetting(window)
                            }
                        }, label: {
                            Text("👉")
                        })
                        .buttonStyle(.plain)
                    }
                })
        }
        .defaultSize(CGSize(width: maxWidth, height: maxHeight))
        .defaultPosition(.topTrailing)
        .windowResizability(.contentSize)
        
        .commands {
            CommandMenu("common") {
                Button("window.size.toggle") {
                    toggleWindowSize()
                }.keyboardShortcut("1", modifiers: .command)
                Divider()
                Button("window.add") {
                    openWindow(id: "other")
                    if let window = NSApplication.shared.windows.last {
                        initWindowSetting(window)
                    }
                }.keyboardShortcut("3", modifiers: .command)
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        for window in NSApplication.shared.windows {
            initWindowSetting(window)
        }
        
        // menubarからいらないもの消す
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
        // シングルアプリケーションとしたいため、ウィンドウを閉じたらアプリケーションも閉じる
        return true
    }
}


func initWindowSetting (_ window: NSWindow){
    // 一番前の位置に
    window.level = .floating
    window.collectionBehavior = .canJoinAllSpaces
    
    // titleをうまいこと消す
    window.titleVisibility = .hidden
    //        window.toolbar = nil
    window.titlebarAppearsTransparent = true
    window.backgroundColor = .white
    //        window.standardWindowButton(.closeButton)!.isHidden = true
    window.standardWindowButton(.miniaturizeButton)!.isHidden = true
    window.standardWindowButton(.zoomButton)!.isHidden = true
    
//    window.backgroundColor = NSColor.white.withAlphaComponent(0.00001)
    window.backgroundColor = NSColor.white.withAlphaComponent(0.1)
    window.isOpaque = false
    //        window.hasShadow = false
}

func toggleWindowSize(){
    if let window = NSApplication.shared.currentEvent?.window {
        if (window.frame.size.height < 50){
            window.setContentSize(NSSize(width: maxWidth,height: maxHeight))
        } else{
            window.setContentSize(NSSize(width: minWidth,height: minHeight))
        }
        
        window.level = .floating
        window.collectionBehavior = .canJoinAllSpaces
    }
}
