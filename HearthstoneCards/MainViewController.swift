//
//  MainViewController.swift
//  HearthstoneCards
//
//  Created by Jeremiah Bonham on 2/18/16.
//  Copyright © 2016 Jeremiah Bonham. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITableViewController{
    

    
    var classes = ["rogue","mage","warlock","druid","warrior","shaman","hunter","paladin","priest","neutral"]
    var thisSelectedClass = ""
    
    
    
    
    @IBOutlet var refresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func callRefresh(sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = self.classes[indexPath.row].uppercaseString
        return cell
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedClass = classes[indexPath.row].lowercaseString
        let destinationVC = SpecificClassCardsVC()
        
        destinationVC.classSelected = selectedClass
        print(selectedClass)
        //destinationVC.performSegueWithIdentifier("segueSpecific", sender: self)
        thisSelectedClass = classes[indexPath.row].lowercaseString
        self.performSegueWithIdentifier("segueSpecific", sender: classes[indexPath.row])
        
    }

   
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a variable that you want to send
        let newProgramVar = thisSelectedClass

        
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destinationViewController as! SpecificClassCardsVC
        destinationVC.classSelected = newProgramVar
    }
}
    
    
    
//}