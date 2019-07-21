//
//  ToDoListManager.swift
//  ToDoList
//
//  Created by Gokul Viswanathan on 2019-07-21.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation

class ToDoListManager {
    
    var data: [ToDoItem]
    
    init() {
        let item:ToDoItem = ToDoItem(description: "Fake Data")
        self.data = Array(repeating: item, count: 3)
    }
    
    func getItems() -> [ToDoItem] {
        return self.data
    }
    
    func count() -> Int {
        return self.getItems().count
    }
    
    func addItem(item: ToDoItem) {
        self.data.append(item)
    }
}
