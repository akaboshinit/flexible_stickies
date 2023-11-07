import SwiftUI
import WebKit

public struct WebView: NSViewRepresentable {
    var webView = WKWebView()
    var urlString: String
    
    private let webViewDelegate = WebViewDelegate()
    
    public func makeNSView(context: Context) -> WKWebView {
        let view = makeView()
        return view
    }
    
    public func updateNSView(_ view: WKWebView, context: Context) {}
    
    public func goBack (){
        print("goBack")
        webView.goBack()
    }
}

class WebViewDelegate: NSObject, WKUIDelegate {
    func webView(_ webView: WKWebView,
                 createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction,
                 windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
}

private extension WebView {
    func makeWebView() -> WKWebView {
        //        guard let configuration = self.configuration else { return WKWebView() }
        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView.allowsBackForwardNavigationGestures = true
        webView.frame = .zero
        webView.uiDelegate = webViewDelegate  // Register the delegate
        return webView
    }
    
    func makeView() -> WKWebView {
        let view = makeWebView()
        tryLoad(URL(string:urlString), into: view)
        
        return view
    }
    
    func tryLoad(_ url: URL?, into view: WKWebView) {
        guard let url = url else { return }
        view.load(URLRequest(url: url))
    }
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: "https://www.notion.so/Todo-1ee65e5b6a0d4a4cbb8cecd1991eb6da?pvs=4")
    }
}
