//
//  CaseStudyDetailViewController.swift
//  KM&T World
//
//  Created by Syed Muneeb Kazmi on 29/09/2015.
//  Copyright © 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit

class CaseStudyDetailViewController: UIViewController, UIWebViewDelegate {
    
    var userObject = NSDictionary()
    var caseStudy: String?
    @IBOutlet weak var webView: UIWebView!
    
    let spinner = customActivityIndicator(text: "Loading")
    let attchBioSpinner = customActivityIndicator(text: "attaching")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let caseStudyLink = userObject["caseStudyLink"] as? String {
            
            caseStudy = caseStudyLink
        
        }
        
        self.view.addSubview(spinner)
        let urlPdf = NSURL(string: caseStudy!);
        let requestObj = NSURLRequest(URL: urlPdf!)
        webView.delegate = self
        webView.loadRequest(requestObj)

        // Do any additional setup after loading the view.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
         self.spinner.hide()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
       
    }

    @IBAction func shareCaseStudy(sender: AnyObject) {
        
        let activityController = UIActivityViewController(activityItems: ["See attached for KM&T Case Study"], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
        let presCon = activityController.popoverPresentationController
        presCon?.barButtonItem = sender as? UIBarButtonItem
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
