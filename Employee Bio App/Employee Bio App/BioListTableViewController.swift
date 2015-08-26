//
//  BioListTableViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 20/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit


struct WeatherSummary {
    var id: String
}


class BioListTableViewController: UITableViewController {
    
    
    var cellTapped = Int()


    @IBOutlet var tableview: UITableView!
    
    //private var notes = Array<Note>()
    
    var bioArray = NSArray(){
    
        didSet{
            dispatch_async(dispatch_get_main_queue()) {
                self.tableview.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        switch cellTapped {
            
        case 0:
            
            test()
            
        case 1:
            test()
        default:
            test()
        
        }
        
   }
    
    func test() {
    
        
        println("This is TWEST")
        
        
        var weatherArray = [WeatherSummary]()
        var request = NSMutableURLRequest(URL: NSURL(string: "https://employee-bio-app-kmandt-syedkazmi.c9.io/user/all")!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        var err: NSError?
       
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        println("Response: \(response)")
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSArray
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
        if(err != nil) {
        
        println(err!.localizedDescription)
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: '\(jsonStr)'")
        
        dispatch_async(dispatch_get_main_queue()) {
        
        var alert = UIAlertController(title: "Alert", message: "Seems to be an error with server. Try Again Later", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        }
        
        
        }
        else {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        // The JSONObjectWithData constructor didn't return an error. But, we should still
        // check and make sure that json has a value using optional binding.
        var newWeather = WeatherSummary(id:"")
        
        if let parseJSON = json {
        
        for weather in parseJSON {
        
        if let id = weather["employeeName"] as? String{
        println(" LOOK HERE \(id)")
        newWeather.id = id
        }
        }
        
        weatherArray.append(newWeather)
        
        self.bioArray = parseJSON
            
        }
        else {
        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: \(jsonStr)")
        
        }}
        
        })
        
        
        
        task.resume()
    }
    
    func testTwo(){
    
        println("THIS IS TEST 2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.bioArray.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bioCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        
        let weatherSummary: AnyObject = bioArray[indexPath.row]
        
        if let id = weatherSummary["employeeName"] as? String
        {
            cell.textLabel?.text = id
            
        }
        
        if let job = weatherSummary["sector"] as? String {
            cell.detailTextLabel?.text = job
        
        }


        return cell
    }
    

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
