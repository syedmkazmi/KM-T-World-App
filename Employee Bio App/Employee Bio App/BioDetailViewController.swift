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

    // Outlet for the webView where we load the URL for the bio from the server or dropbox
    @IBOutlet weak var webView: UIWebView!
    var userObject = NSDictionary()
    var emailSender: String?
    var userBioLink: String?
    var dta:NSData?
    
    
    // Creating a activity indicator and setting its text
    let spinner = customActivityIndicator(text: "Loading")
    let attchBioSpinner = customActivityIndicator(text: "attaching")
    
    
    //@IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        // Starting the the activity indicator spinner
        self.view.addSubview(spinner)
        
        if let userBio = userObject["bioLink"] as? String {
            
            userBioLink = userBio
        }
        // Loading the
        let urlPdf = NSURL(string: userBioLink!);
        let requestObj = NSURLRequest(URL: urlPdf!)
        webView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
        
        /*if let id = weather["employeeName"] as? String{
           // name.text = id
        }*/
        
        if let email = userObject["email"] as? String{
            emailSender = email
        }
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        self.spinner.hide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func shareBio(sender: AnyObject) {
        
        //presentViewController( activityVC, animated: true, completion: nil )
        
        self.view.addSubview(attchBioSpinner)
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(URL: NSURL(string: userBioLink!)!)
        request.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
            
            dispatch_async(dispatch_get_main_queue())
                {
                    let activityController = UIActivityViewController(activityItems: ["See attached for KM&T Employee Bio", data!], applicationActivities: nil)
                    self.presentViewController(activityController, animated: true, completion: nil)
                    let presCon = activityController.popoverPresentationController
                    presCon?.barButtonItem = sender as? UIBarButtonItem
                    self.attchBioSpinner.hide()
                }
           
       

            
            
            //self.view.addSubview(self.attchBioSpinner)
            /*let mailComposeViewController = self.configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail(){
                
                mailComposeViewController.addAttachmentData(data!, mimeType: "application/pdf", fileName: "bio.pdf")
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)

                
            } else {
                self.showSendMailErrorAlert()
                
            }*/
            //print("Entered share bio function")
            
            
        })
        
        task.resume()
        
        }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setSubject("KM&T Employee Bio")
        mailComposerVC.setMessageBody("Please see the link below for the KM&T Employee Bio. Bio Link: \(userBioLink!)", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
      
        let sendMailErrorAlert  = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail. Please check email configuration and try again", preferredStyle: .Alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) -> Void in
            print("The user is okay.")
        }
        
        sendMailErrorAlert.addAction(yesAction)
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil)
        
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


