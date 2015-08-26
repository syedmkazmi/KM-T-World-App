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
    var logoutAuth:Bool = false
    var tappedButton:Bool = false
    
    @IBOutlet weak var bioButton: UIButton!
    @IBAction func employeeBio(sender: AnyObject) {
      
    }
   
    
    
    var x:Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        println("\(username)")
       
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarFrame.size.height
       
              //fName.text = "\(username)"
        //jobT.text = "\(jobTitle)"

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
