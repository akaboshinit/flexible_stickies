//
//  ContentView.swift
//  flexible_stickies
//
//  Created by redstar16 on 2023/10/23.
//

import SwiftUI

struct ContentView: View {
    private var webView: WebView
    
    init(webView: WebView) {
        self.webView = webView
    }
    
    var body: some View {
        webView
    }
}

#Preview {
    ContentView(webView: WebView(urlString: "https://www.notion.so/Todo-1ee65e5b6a0d4a4cbb8cecd1991eb6da?pvs=4"))
}
