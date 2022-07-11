//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Muhammadjon Loves on 7/6/22.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {
    
    var theUrl: String!

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: theUrl) {
            webView.load(URLRequest(url: url))
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
