import UIKit
import WebKit

class WebViewController: UIViewController{
    
    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        let myURL = URL(string:"https://www.digitalsuzie.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view = webView
    }
}
