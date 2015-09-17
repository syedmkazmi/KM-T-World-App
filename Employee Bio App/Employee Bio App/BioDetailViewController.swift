//
//  BioDetailViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 20/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit
import MessageUI
import Foundation
import QuickLook

class BioDetailViewController: UIViewController, MFMailComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate {

   
    @IBOutlet weak var webView: UIWebView!
    var weather = NSDictionary()
    var emailSender: String?
    
    var docController:UIDocumentInteractionController!
    
    //@IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let url = NSURL(fileURLWithPath: "http://kmandtworld.com/employeeBio/John%20Smith.pdf")
        /*let fileURL = NSBundle.mainBundle().URLForResource("http://kmandtworld.com/employeeBio/John%20Smith.pdf", withExtension: "pdf")!
        
        self.docController = UIDocumentInteractionController(URL: fileURL)
        self.docController.delegate = self
        self.docController.presentOpenInMenuFromRect(self.view.bounds, inView: self.view, animated: true)*/
        
        let urlPdf = NSURL(string: "http://kmandtworld.com/employeeBio/John%20Smith.pdf");
        let requestObj = NSURLRequest(URL: urlPdf!)
        webView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
        
        if let id = weather["employeeName"] as? String{
           // name.text = id
        }
        
        if let email = weather["email"] as? String{
            emailSender = email
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func shareBio(sender: AnyObject) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        
        }
        print("Entered share bio function")
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setSubject("KM&T Employee Bio")
        mailComposerVC.setMessageBody("this is test email from \(emailSender!)", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check email configuration and try again", delegate: self, cancelButtonTitle: "OK")
        
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


