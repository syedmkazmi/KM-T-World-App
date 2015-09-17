//
//  LoginViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 20/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    
    //@IBOutlet weak var loginProgress: UIProgressView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint?
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint?
    
    @IBOutlet weak var rememberMeButton: UIButton!
    // Outlets to store store user input
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var json: NSDictionary!
    
    
    @IBAction func swipe(sender: AnyObject) {
        
        print("swipe down")
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    @IBAction func forgotPassword(sender: AnyObject) {
        
        if let url = NSURL(string: "http://healthyworkforce.herokuapp.com/signup") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    /*var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter) / 100.0
            let animated = counter != 0
            
            //loginProgress.setProgress(fractionalProgress, animated: animated)
            
        }
    }*/
    
    
    // Function to authenticate and login user
    @IBAction func LoginAuthentication(sender: AnyObject) {
        
        // Save user input to local variables
        let pass:String = password.text!
        let uname:String = username.text!
        
        /*self.counter = 0
        for i in 0..<100 {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                sleep(1)
                dispatch_async(dispatch_get_main_queue(), {
                    self.counter++
                    return
                })
            })
        }
        */
        // Function Check
        print("Pressed Login")
        
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
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
        } catch var error as NSError {
            err = error
            request.HTTPBody = nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Getting data back from the response
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            var err: NSError?
            
            do{
                self.json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            } catch {
            
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil)
            {
                
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                
                dispatch_async(dispatch_get_main_queue())
                    {
                        self.username.layer.borderWidth = 1.5;
                        self.username.layer.cornerRadius = 5.0;
                        self.username.layer.borderColor = UIColor.redColor().CGColor
                        
                        self.password.layer.borderWidth = 1.5;
                        self.password.layer.cornerRadius = 5.0;
                        self.password.layer.borderColor = UIColor.redColor().CGColor
                    
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
                
                
                if let parseJSON = self.json
                {
                    User.name = parseJSON["employeeName"] as? String
                    User.email = parseJSON["email"] as? String
                    User.job = parseJSON["jobTitle"] as? String
                    
                    // parseJSON contains the return data. We are programmatically creating a segue between two views
                   //  passing data between them.
                    dispatch_async(dispatch_get_main_queue())
                        {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("mainView") as! MainViewController
                        var fullname = parseJSON["employeeName"] as! String
                        var job = parseJSON["jobTitle"] as! String
                        var email = parseJSON["email"] as! String
                        vc.username = fullname
                        vc.jobTitle = job
                        vc.userEmail = email
                        self.presentViewController(vc, animated: true, completion: nil)
                        
                }
                        }
                else
                {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                    
                }
            }
        })
        
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loginProgress.setProgress(0, animated: true)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let usernameIsNotNil = userDefaults.objectForKey("username") as? String {
            
            self.username.text = userDefaults.objectForKey("username") as! String
        }
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.view.addGestureRecognizer(self.swipeDown)
        self.username.keyboardType = UIKeyboardType.EmailAddress
        username.autocorrectionType = UITextAutocorrectionType.No
        //username.borderStyle = UITextBorderStyle(rawValue: 0)!
        username.layer.borderWidth = 1.5;
        username.layer.cornerRadius = 5.0;
        username.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        password.layer.borderWidth = 1.5;
        password.layer.cornerRadius = 5.0;
        password.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        loginButton.layer.borderWidth = 0.0;
        loginButton.layer.cornerRadius = 5.0;
           }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        centerAlignUsername!.constant -= view.bounds.width
        centerAlignPassword!.constant -= view.bounds.width
        //loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: {
            self.centerAlignUsername!.constant += self.view.bounds.width
            self.centerAlignPassword!.constant += self.view.bounds.width
            //self.loginButton.alpha = 1
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }

    @IBAction func rememberMe(sender: AnyObject) {
        
        if (username.text == "") {
            
            let alertController = UIAlertController(title: "Remember Me", message:
                "The email field seems to be empty. Please enter the your email address within the email field and try again", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        else {
            
            let email = username.text
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setValue(email, forKey: "username")
            userDefaults.synchronize()
            
            let alertController = UIAlertController(title: "Remember Me", message:
                "Your email \(email) has been remembered", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Great!", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            let image = UIImage(named: "checkIcon.png") as UIImage!
            //rememberMeButton  = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            rememberMeButton.setImage(image, forState: UIControlState.Normal)
            
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

}
