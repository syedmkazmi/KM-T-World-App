//
//  LoginViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 20/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    // Outlets to store store user input
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // Function to authenticate and login user
    @IBAction func LoginAuthentication(sender: AnyObject) {
        
        // Save user input to local variables
        var pass:String = password.text
        var uname:String = username.text
        
        // Function Check
        println("Pressed Login")
        
        // Setting up a variable to save the API link
        var request = NSMutableURLRequest(URL: NSURL(string: "https://employee-bio-app-kmandt-syedkazmi.c9.io/login/mob")!)
        
        // Creating a session
        var session = NSURLSession.sharedSession()
        
        // Setting the HTTP method call
        request.HTTPMethod = "POST"
        
        // Showing network indicator to user
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // Setting up parameter values to be send to the API
        var params = ["email":"\(uname)", "password":"\(pass)"] as Dictionary<String, String>
        
        // Setting up request body and header and making the request
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Getting data back from the response
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil)
            {
                
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                
                dispatch_async(dispatch_get_main_queue())
                    {
                    
                        var alert = UIAlertController(title: "Alert", message: "Oops! Your login details don't match. Please note both username & password are case sensitive", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    }
            }
                
            else
            {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                
                if let parseJSON = json
                {
                    // parseJSON contains the return data. We are programmatically creating a segue between two views
                   //  passing data between them.
                    dispatch_async(dispatch_get_main_queue())
                        {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("mainView") as! MainViewController
                        var fullname = parseJSON["employeeName"] as! String
                        var job = parseJSON["jobTitle"] as! String
                        vc.username = fullname
                        vc.jobTitle = job
                        self.presentViewController(vc, animated: true, completion: nil)
                        
                }
                        }
                else
                {
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
