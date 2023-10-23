import SwiftUI
import WebKit

class WebViewDelegate: NSObject, WKUIDelegate {
    func webView(_ webView: WKWebView,
             createWebViewWith configuration: WKWebViewConfiguration,
             for navigationAction: WKNavigationAction,
             windowFeatures: WKWindowFeatures) -> WKWebView? {

        if navigationAction.targetFrame?.isMainFrame != true {
            let newWebView = WKWebView(frame: webView.frame, configuration: configuration)
            newWebView.load(navigationAction.request)
            newWebView.uiDelegate = self
            webView.superview?.addSubview(newWebView)
            return newWebView
        }

        return nil
    }
}

public struct WebView: NSViewRepresentable {
    private let webViewDelegate = WebViewDelegate()
    
    public init(
        url: URL? = nil,
        configuration: WKWebViewConfiguration? = nil,
        webView: @escaping (WKWebView) -> Void = { _ in }) {
        self.url = url
        self.configuration = configuration
        self.webView = webView
    }
    
    private let url: URL?
    private let configuration: WKWebViewConfiguration?
    private let webView: (WKWebView) -> Void

    public func makeNSView(context: Context) -> WKWebView {
        makeView()
    }
    
    public func updateNSView(_ view: WKWebView, context: Context) {}
}

private extension WebView {

    func makeWebView() -> WKWebView {
//        guard let configuration = self.configuration else { return WKWebView() }
        let wkPreferences = WKPreferences()
        wkPreferences.javaScriptCanOpenWindowsAutomatically = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = wkPreferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = webViewDelegate // Register the delegate
        return webView
    }
    
    func makeView() -> WKWebView {
        let view = makeWebView()
        webView(view)
        tryLoad(url, into: view)

        return view
    }
    
    func tryLoad(_ url: URL?, into view: WKWebView) {
        guard let url = url else { return }
        view.load(URLRequest(url: url))
    }
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://www.notion.so/Todo-1ee65e5b6a0d4a4cbb8cecd1991eb6da?pvs=4"))
    }
}
