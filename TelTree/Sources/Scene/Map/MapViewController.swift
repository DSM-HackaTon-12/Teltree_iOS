import RxSwift
import RxCocoa
import UIKit
import SnapKit
import Then
import WebKit

class MapViewController: BaseViewController {
    lazy var webview: WKWebView = {
        let controller = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        let tempWebView = WKWebView(frame: .zero, configuration: self.generateWKWebViewConfiguration())
        return tempWebView
    }()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        let request = URLRequest(
            url: URL(string: "http://192.168.64.203:3000/map")!,
            cachePolicy: .returnCacheDataElseLoad
        )
        self.webview.scrollView.isScrollEnabled = true
        
        self.webview.load(request)
    }
    private func generateWKWebViewConfiguration() -> WKWebViewConfiguration {

        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences

        self.setWebCookie(cookie: [
            "access_token": Token.accessToken ?? "nil"
        ], configuration: configuration)

        return configuration
    }
    private func setWebCookie(cookie: [String: String], configuration: WKWebViewConfiguration) {
        let dataStore = WKWebsiteDataStore.nonPersistent()
        cookie.forEach {
            dataStore.httpCookieStore.setCookie(HTTPCookie(properties: [
                .domain: "dsm-hackathon24.netlify.app",
                .path: "/",
                .name: $0.key,
                .value: $0.value,
                .secure: "TRUE"
            ])!)
        }
        configuration.websiteDataStore = dataStore
    }
    override func addView() {
        [
            webview
        ].forEach {
            view.addSubview($0)
        }
    }
    override func setLayout() {
        webview.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(90)
        }
    }
}
