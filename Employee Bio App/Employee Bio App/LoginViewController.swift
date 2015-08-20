//
//  LoginViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 20/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
  
    @IBAction func LoginAuthentication(sender: AnyObject) {
        
        var pass:String = password.text
        var uname:String = username.text
        
        println("Pressed Login")
        
        var request = NSMutableURLRequest(URL: NSURL(string: "https://employee-bio-app-kmandt-syedkazmi.c9.io/login/mob")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        var params = ["email":"\(uname)", "password":"\(pass)"] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    var alert = UIAlertController(title: "Alert", message: "Oops! Wrong Details, Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
                
            }
            else {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                
                if let parseJSON = json {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("mainView") as! MainViewController
                        var fullname = parseJSON["employeeName"] as! String
                        var job = parseJSON["jobTitle"] as! String
                        vc.username = fullname
                        vc.jobTitle = job
                        self.presentViewController(vc, animated: true, completion: nil)
                        
                    }
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    
                    /*var fullname = parseJSON["fullname"] as! String
                    println("Succes: \(fullname)")*/
                    
                    /*var region = parseJSON["region"] as! String
                    println("Region: \(region)")
                    
                    var uTarget = parseJSON["target"] as! String
                    println("Target: \(uTarget)")*/
                    
                    
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                    
                }
            }
        })
        
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
