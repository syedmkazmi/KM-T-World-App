//
//  CaseStudySectorListTableViewController.swift
//  KM&T World
//
//  Created by Syed Muneeb Kazmi on 29/09/2015.
//  Copyright © 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit

class CaseStudySectorListTableViewController: UITableViewController {
    
   
    
    let selectSector: [String] = ["Operations","Healthcare","Public Sector","Office & Transactional"]
    
    var sectorIcon: [UIImage] = [
        UIImage(named: "MMROIcon.pdf")!,
        UIImage(named: "healthcareIcon.pdf")!,
        UIImage(named: "publicSectorIcon.pdf")!,
        UIImage(named: "officeIcon.pdf")!,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80.0

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return selectSector.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("caseStudySector", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = selectSector[indexPath.row]
        cell.imageView?.image = sectorIcon[indexPath.row]

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destinationViewController as? CaseStudyListTableViewController {
            let indexPath = self.tableView.indexPathForSelectedRow
            
            if let row:Int = indexPath?.row {
                
                destination.cellTapped = row
            }
        }
        
    }
}
