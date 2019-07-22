//
//  ToDoListManager.swift
//  ToDoList
//
//  Created by Gokul Viswanathan on 2019-07-21.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation

class ToDoListManager {
    
    let databaseHelper: DatabaseHelper
    
    init() {
        databaseHelper = DatabaseHelper()
    }
    
    func getItems() -> [ToDoItem] {
        return self.databaseHelper.getItems() ?? [ToDoItem]()
    }
    
    func count() -> Int {
        return self.getItems().count
    }
    
    func addItem(item: ToDoItem) {
        self.databaseHelper.insertItems(item: item)
    }
    
    func updateItem(item: ToDoItem) {
        self.databaseHelper.updateItem(item: item)
    }
    
}
