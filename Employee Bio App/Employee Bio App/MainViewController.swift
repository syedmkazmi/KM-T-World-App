//
//  MainViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 20/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    
    var username:AnyObject = ""
    var jobTitle:AnyObject = ""
    var userEmail:AnyObject = ""
    var logoutAuth:Bool = false
    var tappedButton:Bool = false
    
    // An array to the hold the bios returned from the server
    var bioArray = NSArray()
    
    //Outlet for the Bio Button
    @IBOutlet weak var bioButton: UIButton!
    @IBAction func employeeBio(sender: AnyObject) {
     
        print("Tapped on the bios button")
    }
   
    
    @IBAction func caseStudies(sender: AnyObject) {
        
        print("Tapped on the case study button")
    }
    
    
    @IBAction func userSettings(sender: AnyObject) {
        
        print("Tapped on the setting button")
        
    
    }
 
    
    var x:Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print("\(username)")
       
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarFrame.size.height
       
    }
    
    
    override func viewDidAppear(animated: Bool) {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "settings") {
            // pass data to next view
            let viewController = segue.destinationViewController as! SettingsTableViewController
            // Getting the user details from the NSUserDefaults and setting them to the variables in the settings view and passing
            // them along to the settings view.
            viewController.username = User.name!
            viewController.jobTitle = User.job!
            viewController.userEmail = User.email!
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
