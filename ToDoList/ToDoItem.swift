//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Gokul Viswanathan on 2019-06-08.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation

class ToDoItem {
    let id: Int64
    let description: String
    let dateCreated: Date
    var completed: Bool
    var dateUpdated: Date?
    
    init(description: String) {
        self.description = description
        self.dateCreated = Date()
        self.completed = false
        self.dateUpdated = nil
        self.id = 0
    }
    
    init(id: Int64, description: String, completed: Bool, dateCreated: Date, dateUpdated: Date?) {
        self.id = id
        self.description = description
        self.dateCreated = dateCreated
        self.completed = completed
        self.dateUpdated = dateUpdated
    }
    
    func completeItem() {
        completed = true
    }
    
    func dateCreatedAsString() -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self.dateCreated)
    }
    
    func dateUpdatedAsString() -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat
        if((self.dateUpdated) != nil){
            return dateFormatter.string(from: self.dateUpdated!)
        }
        else{
            return "Yet to complete"
        }
        
    }
}
