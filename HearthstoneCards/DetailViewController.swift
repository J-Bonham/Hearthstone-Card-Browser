//
//  DetailViewController.swift
//  HearthstoneCards
//
//  Created by Jeremiah Bonham on 2/18/16.
//  Copyright © 2016 Jeremiah Bonham. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var test: UILabel!
    @IBOutlet var test2: UILabel!
    @IBOutlet var test3: UILabel!
    @IBOutlet var test4: UILabel!
    
    
    
    
    var thisCard: Cards = Cards.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.text = thisCard.name.uppercaseString
        test2.text = thisCard.type.uppercaseString
        test3.text = thisCard.playerClass.uppercaseString
        test4.text = thisCard.mana.uppercaseString
        
        let convetedURL = thisCard.img
        let startIndex = convetedURL.startIndex.advancedBy(4)
        
        let finalURL = convetedURL.substringFromIndex(startIndex)
        
        let converted = "https" + finalURL
        
        if let checkedUrl = NSURL(string: converted) {
            image.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl)
        }
        
    }
    
    func downloadImage(url: NSURL) {
        
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                let newImage = UIImage(data: data)
                self.image.image = newImage!
                
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    
}