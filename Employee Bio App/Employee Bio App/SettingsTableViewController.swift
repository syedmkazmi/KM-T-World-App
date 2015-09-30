//
//  SettingsTableViewController.swift
//  
//
//  Created by Syed Muneeb Kazmi on 10/09/2015.
//
//

import UIKit
import CoreData

class SettingsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var username:AnyObject = ""
    var jobTitle:AnyObject = ""
    var userEmail:AnyObject = ""
    
    var photos = [UIImage]()

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var versionNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.userPhoto.layer.cornerRadius = CGRectGetWidth(self.userPhoto.frame)/2.0
        self.userPhoto.layer.masksToBounds = true
        self.userPhoto.contentMode = UIViewContentMode.ScaleAspectFill
        self.userPhoto.layer.borderWidth = 1.0
        self.userPhoto.layer.borderColor = UIColor.grayColor().CGColor
    
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let userPhotoIsNotNil = userDefaults.objectForKey("userPhoto") as? NSData {
            
              let img = UIImage(data: userPhotoIsNotNil)
            
                userPhoto.image = img
            }
            
        
              
        if let appVersion = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            
            versionNumber.text? = appVersion
        }

        name.text? = username as! String
        job.text? = jobTitle as! String
        email.text? = userEmail as! String
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String: AnyObject]){
    
    
        self.dismissViewControllerAnimated(true, completion: nil)
        let newImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.userPhoto.image = newImage
        let imageData = UIImageJPEGRepresentation(newImage, 1)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(imageData, forKey: "userPhoto")
        userDefaults.synchronize()
    
    }

    @IBAction func getPhoto(sender: AnyObject) {
        
        self.getFromPhotos()
    }
    
    func getFromPhotos(){
        let picker = UIImagePickerController()
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func removePhoto(sender: AnyObject) {
        
        userPhoto.image = UIImage(named: "userDefaultIcon.png")
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject("userDefaultIcon.png", forKey: "userPhoto")
        userDefaults.synchronize()
    }
    
    @IBAction func logoutUser(sender: AnyObject) {
        
        // Setting up a variable to save the API link
        let request = NSMutableURLRequest(URL: NSURL(string: "https://employee-bio-app-kmandt-syedkazmi.c9.io/mob/logout")!)
        
        // Creating a session
        let session = NSURLSession.sharedSession()
        
        // Setting the HTTP method call
        request.HTTPMethod = "GET"
        
        // Showing network indicator to user
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // Setting up parameter values to be send to the API
        //var params = ["email":"\(uname)", "password":"\(pass)"] as Dictionary<String, String>
        
        // Setting up request body and header and making the request
        let _: NSError?
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameter: nil, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Getting data back from the response
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
            print("Response: \(response)")
            //var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("Body: \(strData)")
            //var err: NSError?
            //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil)
            {
                
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                
            }
                
            else
            {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                print("entering logout")
                dispatch_async(dispatch_get_main_queue())
                    {
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("loginView") as! LoginViewController
                        self.presentViewController(vc, animated: true, completion: nil)
                        
                }
                
            }
        })
        
        task.resume()
    }
    // MARK: - Table view data source

       /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
