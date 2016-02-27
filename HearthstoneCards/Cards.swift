//
//  Cards.swift
//  HearthstoneCards
//
//  Created by Jeremiah Bonham on 2/18/16.
//  Copyright © 2016 Jeremiah Bonham. All rights reserved.
//

import Foundation
import UIKit

class Cards: NSObject {
    var name : String!
    var img : String!
    var type : String!
    var mana : String!
    var playerClass : String!
    
    override init() {
        self.name = ""
        self.img = ""
        self.type = ""
        self.mana = ""
        
        self.playerClass = ""
    }
    
    init(name : String , img : String,type : String, mana : String, playerClass : String) {
        self.name = name
        self.img = img
        self.type = type
        self.mana = mana
        self.playerClass = playerClass
        
        
    }
}
