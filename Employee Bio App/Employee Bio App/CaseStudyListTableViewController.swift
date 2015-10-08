//
//  CaseStudyListTableViewController.swift
//  KM&T World
//
//  Created by Syed Muneeb Kazmi on 29/09/2015.
//  Copyright © 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit

class CaseStudyListTableViewController: UITableViewController {
    
    var refreshCtrl = UIRefreshControl()
    var cellTapped = Int()
    let spinner = customActivityIndicator(text: "Loading")
    var json: NSArray!
    
    @IBOutlet var tableview: UITableView!
    
    var bioArray = NSArray(){
        didSet{
            
            dispatch_async(dispatch_get_main_queue()){
                self.tableview.reloadData()
                //ViewControllerUtils().hideActivityIndicator(self.view)
                self.spinner.hide()
            }}}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80.0
        //self.refreshCtrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //self.refreshCtrl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        //self.tableView?.addSubview(refreshCtrl)
 

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // A switch Statement to check which cell was tapped and which API link to call
        switch cellTapped
        {
            
        case 0:
            getOperationsCaseStudy()
        case 1:
            getHealthcareCaseStudy()
        case 2:
            getPublicSectorCaseStudy()
        case 3:
            getOfficeCaseStudy()
        default:
            getAllCaseStudy()
        }
    }
    
    /*func refresh(sender:AnyObject)
    {
        getOfficeCaseStudy()
        self.refreshCtrl.endRefreshing()
    }*/
    
    // gets all operations case studies
    func getOperationsCaseStudy(){
        
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            //To start animating
            self.view.addSubview(spinner)
            
            
            print("This is TWEST")
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://kmandt-world-app.herokuapp.com/user/casestudy/operations")!)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            
            let _: NSError?
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                //var err: NSError?
                
                do{
                    self.json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
                } catch {
                    
                }
                
                
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    
                    print(err!.localizedDescription)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let alert = UIAlertController(title: "Alert", message: "Seems to be an error with server. Try Again Later", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }}
                else {
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    //To to long tasks
                    // LoadingOverlay.shared.hideOverlayView()
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    //var newWeather = WeatherSummary(id:"")
                    
                    if let parseJSON = self.json {
                        
                        
                        self.bioArray = parseJSON
                        
                        
                    }
                    else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("Error could not parse JSON: \(jsonStr)")
                        
                    }}
                
            })
            
            
            task.resume()
            
        }
            
        else {
            
            print("Internet connection FAILED")
            let internetErrorAlert  = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "okay", style: .Default) { (action) -> Void in
                print("The user is okay.")
            }
            
            internetErrorAlert.addAction(yesAction)
            self.presentViewController(internetErrorAlert, animated: true, completion: nil)
        }
    }
    
    func getHealthcareCaseStudy(){
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            //To start animating
            self.view.addSubview(spinner)
            
            
            print("This is TWEST")
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://kmandt-world-app.herokuapp.com/user/casestudy/healthcare")!)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            
            let _: NSError?
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                //var err: NSError?
                
                do{
                    self.json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
                } catch {
                    
                }
                
                
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    
                    print(err!.localizedDescription)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let alert = UIAlertController(title: "Alert", message: "Seems to be an error with server. Try Again Later", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }}
                else {
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    //To to long tasks
                    // LoadingOverlay.shared.hideOverlayView()
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    //var newWeather = WeatherSummary(id:"")
                    
                    if let parseJSON = self.json {
                        
                        
                        self.bioArray = parseJSON
                        
                        
                    }
                    else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("Error could not parse JSON: \(jsonStr)")
                        
                    }}
                
            })
            
            
            task.resume()
            
        }
            
        else {
            
            print("Internet connection FAILED")
            let internetErrorAlert  = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "okay", style: .Default) { (action) -> Void in
                print("The user is okay.")
            }
            
            internetErrorAlert.addAction(yesAction)
            self.presentViewController(internetErrorAlert, animated: true, completion: nil)
        }
    }
    
    func getPublicSectorCaseStudy(){
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            //To start animating
            self.view.addSubview(spinner)
            
            
            print("This is TWEST")
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://kmandt-world-app.herokuapp.com/user/casestudy/publicSector")!)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            
            let _: NSError?
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                //var err: NSError?
                
                do{
                    self.json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
                } catch {
                    
                }
                
                
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    
                    print(err!.localizedDescription)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let alert = UIAlertController(title: "Alert", message: "Seems to be an error with server. Try Again Later", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }}
                else {
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    //To to long tasks
                    // LoadingOverlay.shared.hideOverlayView()
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    //var newWeather = WeatherSummary(id:"")
                    
                    if let parseJSON = self.json {
                        
                        
                        self.bioArray = parseJSON
                        
                        
                    }
                    else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("Error could not parse JSON: \(jsonStr)")
                        
                    }}
                
            })
            
            
            task.resume()
            
        }
            
        else {
            
            print("Internet connection FAILED")
            let internetErrorAlert  = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "okay", style: .Default) { (action) -> Void in
                print("The user is okay.")
            }
            
            internetErrorAlert.addAction(yesAction)
            self.presentViewController(internetErrorAlert, animated: true, completion: nil)
        }
    }
    
    func getOfficeCaseStudy(){
        
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            //To start animating
            self.view.addSubview(spinner)
            
            
            print("This is TWEST")
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://kmandt-world-app.herokuapp.com/user/casestudy/office")!)
            let session = NSURLSession.sharedSession()
            request.HTTPMethod = "GET"
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            
            let _: NSError?
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                //var err: NSError?
                
                do{
                    self.json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
                } catch {
                    
                }
                
                
                
                // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
                if(err != nil) {
                    
                    print(err!.localizedDescription)
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        let alert = UIAlertController(title: "Alert", message: "Seems to be an error with server. Try Again Later", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                    }}
                else {
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    //To to long tasks
                    // LoadingOverlay.shared.hideOverlayView()
                    // The JSONObjectWithData constructor didn't return an error. But, we should still
                    // check and make sure that json has a value using optional binding.
                    //var newWeather = WeatherSummary(id:"")
                    
                    if let parseJSON = self.json {
                        
                        
                        self.bioArray = parseJSON
                        
                        
                    }
                    else {
                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("Error could not parse JSON: \(jsonStr)")
                        
                    }}
                
            })
            
            
            task.resume()
            
        }
            
        else {
            
            print("Internet connection FAILED")
            let internetErrorAlert  = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            
            let yesAction = UIAlertAction(title: "okay", style: .Default) { (action) -> Void in
                print("The user is okay.")
            }
            
            internetErrorAlert.addAction(yesAction)
            self.presentViewController(internetErrorAlert, animated: true, completion: nil)
        }
        
    }
    
    func getAllCaseStudy(){
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.bioArray.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("caseStudyCell", forIndexPath: indexPath)

        // Configure the cell...
        
        
        let Summary: AnyObject = bioArray[indexPath.row]
        
        if let id = Summary["caseStudyTitle"] as? String
        {
            cell.textLabel?.text = id
            cell.textLabel?.numberOfLines = 0
            
        }
        
       cell.imageView?.image = UIImage(named: "pdfIcon.png")
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        
        if let destination = segue.destinationViewController as? CaseStudyDetailViewController {
            
            let indexPath = self.tableView.indexPathForSelectedRow
            if let row:Int = indexPath?.row{
                
                print("ROW \(row)")
                destination.userObject = bioArray[row] as! NSDictionary
            }
            
        }
    }

}
