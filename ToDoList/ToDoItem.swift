//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Gokul Viswanathan on 2019-06-08.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation

class ToDoItem {
    let description: String
    let dateCreated: Date
    var completed: Bool
    
    init(description: String) {
        self.description = description
        self.dateCreated = Date()
        self.completed = false
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
}
