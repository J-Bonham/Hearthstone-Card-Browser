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
    
    var name: String!;
    var cards:[Cards] = []
    
    @IBOutlet var refresh: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCardData()
    }
    
    
    @IBAction func callRefresh(sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    
    func getCardData(){
        
        let requestURL: NSURL = NSURL(string: "https://raw.githubusercontent.com/J-Bonham/hearthstone-db/master/cards/all-cards.json")!
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) {
            
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    let json2 = json["cards"]
                    
                    for var i = 0; i<json2?!.count; ++i {
                        let dictResult = json2?!.objectAtIndex(i) as! NSDictionary
                        //print(dictResult.objectForKey("name") as! String)
                        
                        
                                let newCard = Cards(name: dictResult.objectForKey("name") as! String, img: dictResult.objectForKey("image_url") as! String, type: dictResult.objectForKey("type") as! String, mana: dictResult.objectForKey("set") as! String, playerClass: dictResult.objectForKey("quality") as! String)
                                
                                self.cards.append(newCard)

                    }
                    
                    self.tableView.reloadData()
                    
                } catch {
                    
                    print("Error with Json: \(error)")
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = self.cards[indexPath.row].name.uppercaseString
        cell.detailTextLabel?.text = self.cards[indexPath.row].playerClass.uppercaseString
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //print(self.cards[indexPath.row].img)
        performSegueWithIdentifier("pushDetailView", sender: self.cards[indexPath.row])
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! DetailViewController
        dest.thisCard = sender as! Cards
        
    }
    
    
    
    
    
    
}