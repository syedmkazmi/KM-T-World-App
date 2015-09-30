//
//  LoginViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 20/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit

// THIS CONTROLLER IS RESPONSIBLE FOR AUTHORIZING THE USER FROM THE SERVER & LOGGING THE USER IN.
class LoginViewController: UIViewController {
    
    let spinner = customActivityIndicator(text: "Signing In...")
    //Outlet for the login button
    @IBOutlet weak var loginButton: UIButton!
    //Outlet for the swipe down gesture
    @IBOutlet var swipeDown: UISwipeGestureRecognizer!
    //Outlets for the constraints to be used for animating
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint?
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint?
    // Outlet for the remember me button
    @IBOutlet weak var rememberMeButton: UIButton!
    // Outlets to store store user input
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // A variable to hold the returned json from a successful login
    var json: NSDictionary!
    
    //Action(Function) for the swipe gesture
    @IBAction func swipe(sender: AnyObject) {
        
        print("swipe down")
        self.username.resignFirstResponder()
        self.password.resignFirstResponder()
    }
    
    //Action(Function) for the forgot password button
    @IBAction func forgotPassword(sender: AnyObject) {
        
        // Redirect user to forgot password link on safari
        if let url = NSURL(string: "https://employee-bio-app-kmandt-syedkazmi.c9.io/forgot") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    // Function to authenticate and login user
    @IBAction func LoginAuthentication(sender: AnyObject) {
        
        //To start animating
        self.view.addSubview(spinner)
        
        // Save user input to local variables
        let pass:String = password.text!
        let uname:String = username.text!
        
        //Checking whether the deivce is connected to the internet
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            // Function Check
            print("Pressed Login")
            
            // Setting up a variable to save the API link
            let request = NSMutableURLRequest(URL: NSURL(string: "https://employee-bio-app-kmandt-syedkazmi.c9.io/login/mob")!)
            
            // Creating a session
            let session = NSURLSession.sharedSession()
            
            // Setting the HTTP method call
            request.HTTPMethod = "POST"
            
            // Showing network indicator to user
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            // Setting up parameter values to be send to the API
            let params = ["email":"\(uname)", "password":"\(pass)"] as Dictionary<String, String>
            
            // Setting up request body and header and making the request
            let err: NSError?
            
            do{
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            } catch {
                
                // print(err)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            // Getting data back from the response
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                //var err: NSError?
                
                do { 
                    self.json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                } catch let error as NSError{
                    
                    print("TEST Error \(error)")
                    print(error.localizedDescription)
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
                            
                            let alert = UIAlertController(title: "Alert", message: "Oops! Your login details don't match. Please note both username & password are case sensitive", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    }
                    

                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil)
                {
                    
                }
                    
                else
                {
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    
                    
                    if let parseJSON = self.json
                    {
                        // Save the user details to the user model in User.swift class
                        User.name = parseJSON["employeeName"] as? String
                        User.email = parseJSON["email"] as? String
                        User.job = parseJSON["jobTitle"] as? String
                        
                        // parseJSON contains the return data. We are programmatically creating a segue between two views
                        //  passing data between them.
                        dispatch_async(dispatch_get_main_queue())
                            {
                                
                                self.spinner.hide()
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewControllerWithIdentifier("mainView") as! MainViewController
                                let fullname = parseJSON["employeeName"] as! String
                                let job = parseJSON["jobTitle"] as! String
                                let email = parseJSON["email"] as! String
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
            
        } else {
            //Creating and displaying an Alert box to the user if the device is not connected to the internet
            print("Internet connection FAILED")
            let internetErrorAlert  = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "okay", style: .Default) { (action) -> Void in
                print("The user is okay.")
            }
            
            internetErrorAlert.addAction(yesAction)
            self.presentViewController(internetErrorAlert, animated: true, completion: nil)
        }
        
       
        
    }
    
    // Runs everything within itself once the view loads, similar to main() function in Java
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()

        
        if let usernameIsNotNil = userDefaults.objectForKey("username") as? String {
            
            self.username.text = userDefaults.objectForKey("username") as? String
        }
        
        if let userPasswordIsNotNil = userDefaults.objectForKey("password") as? String{
            
            self.password.text = userDefaults.objectForKey("password") as? String
        }
        
        
        // Setting the status bar style to light color
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        // Add the swipe down gesture to the view
        self.view.addGestureRecognizer(self.swipeDown)
        // Setting the keyboard type for the username text field ONLY!
        self.username.keyboardType = UIKeyboardType.EmailAddress
        // Turning off the autocorrection or suggestions for the keyboard for the username field ONLY.
        username.autocorrectionType = UITextAutocorrectionType.No
        
        // Setting the style and design of both username & password text field
        //username.borderStyle = UITextBorderStyle(rawValue: 0)!
        username.layer.borderWidth = 1.5;
        username.layer.cornerRadius = 5.0;
        username.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        password.layer.borderWidth = 1.5;
        password.layer.cornerRadius = 5.0;
        password.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // Setting the style & design for the login button
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

    // The remember me function which saves the users email address in NSUserdefault
    @IBAction func rememberMe(sender: AnyObject) {
        
        // Checking to see if the username text field is empty, if so, then alert the user
        if (username.text == "" && password.text == "") {
            
            let alertController = UIAlertController(title: "Remember Me", message:
                "The email or password field seems to be empty. Please enter the your email & password within the fields and try again", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        else {
            
            let email = username.text
            let pass = password.text
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setValue(email, forKey: "username")
            userDefaults.setValue(pass, forKey: "password")
            userDefaults.synchronize()
            
            let alertController = UIAlertController(title: "Remember Me", message:
                "Your login details have been remembered", preferredStyle: UIAlertControllerStyle.Alert)
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
