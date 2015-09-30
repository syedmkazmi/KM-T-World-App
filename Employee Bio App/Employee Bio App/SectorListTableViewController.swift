//
//  SectorListTableViewController.swift
//  Employee Bio App
//
//  Created by Syed Muneeb Kazmi on 24/08/2015.
//  Copyright (c) 2015 Knowledge Management & Transfer. All rights reserved.
//

import UIKit

class SectorListTableViewController: UITableViewController {
    
    
    @IBOutlet weak var sectorIconView: UIImageView!
   
    
    struct Summary {
        var id: String
    }
    
    var testArray = NSArray()
    var manuArray = NSArray()
    
    // Array of sector within our company
    var selectSector: [String] = ["Healthcare", "MMRO","Infrastructure","Rail","Mining","Engineering Services","Senior Management"]
    
    var sectorIcon: [UIImage] = [
        UIImage(named: "healthcareIcon.pdf")!,
        UIImage(named: "MMROIcon.pdf")!,
        UIImage(named: "InfrastructureIcon.pdf")!,
        UIImage(named: "RailIcon.pdf")!,
        UIImage(named: "miningIcon.pdf")!,
        UIImage(named: "esIcon.pdf")!,
        UIImage(named: "seniorManageIcon")!
    ]
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80.0
        UIViewController.attemptRotationToDeviceOrientation()
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
        return self.selectSector.count
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.redColor()
    }*/

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) 

        // Configure the cell...
        
        if selectSector.count > 0 {
            
            //let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomCellController
            //var fram = cell.imageView?.frame
            //fram? = CGRectMake( 0, 0, 50, 55 )
           //let imageSize = 80 as CGFloat
           //fram?.size.height = imageSize
           //fram?.size.width = imageSize
            //cell.imageView!.frame = fram!
           // cell.imageView!.layer.cornerRadius = imageSize / 2.0
          //  cell.imageView!.clipsToBounds = true
            
            cell.textLabel?.text = selectSector[indexPath.row]
            //cell.iconView.image = sectorIcon[indexPath.row]
            //cell.sectorTitle.text = selectSector[indexPath.row]
            cell.imageView?.image = sectorIcon[indexPath.row]
            
            
            

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if let destination = segue.destinationViewController as? BioListTableViewController {
          let indexPath = self.tableView.indexPathForSelectedRow
            
            if let row:Int = indexPath?.row {
                
            
              //destination.bioArray = testArray
                
                destination.cellTapped = row
           }
        }
    }
}

