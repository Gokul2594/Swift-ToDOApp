//
//  DatabaseHelper.swift
//  ToDoList
//
//  Created by Gokul Viswanathan on 2019-07-22.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    let db: Connection?
    let items = Table("items")
    let id = Expression<Int64>("id")
    let description = Expression<String>("description")
    let isCompleted = Expression<Bool>("isCompleted")
    let dateAdded = Expression<Date>("dateAdded")
    let dateUpdated = Expression<Date?>("dateUpdated")
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/itemsDb.sqlite3")
            print(path)
            createItemsTable()
        } catch (let message) {
            print(message)
            db = nil
        }
    }
    
    private func createItemsTable() {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        
        do {
            try db!.run(items.create(ifNotExists: true){ t in
                t.column(id, primaryKey: true)
                t.column(description)
                t.column(isCompleted, defaultValue: false)
                t.column(dateAdded)
                t.column(dateUpdated)
            })
        } catch (let message) {
            print(message)
        }
    }
    
    func insertItems(item: ToDoItem) {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        
        let insert = items.insert(
            description <- item.description,
            isCompleted <- item.completed,
            dateAdded <- item.dateCreated,
            dateUpdated <- item.dateUpdated
        )
        
        do {
            try db!.run(insert)
        } catch (let message) {
            print(message)
        }
    }
    
    func getItems() -> [ToDoItem]? {
        if(db == nil) {
            print("Unable to get connection")
            return nil
        }
        do {
            var toDoItems: [ToDoItem] = [ToDoItem]()
            
            for row in try db!.prepare(items) {
                let item = ToDoItem(
                    id: row[id],
                    description: row[description],
                    completed: row[isCompleted],
                    dateCreated: row[dateAdded],
                    dateUpdated: row[dateUpdated]
                )
                toDoItems.append(item)
            }
            return toDoItems
        } catch (let message) {
            print(message)
            return nil
        }
    }
    
    func updateItem(item: ToDoItem) {
        if(db == nil) {
            print("Unable to get connection")
            return
        }
        do {
            let selectedItem = items.filter(id == item.id)
            try db!.run(selectedItem.update(
                isCompleted <- item.completed,
                dateUpdated <- item.dateUpdated
            ))
        } catch (let message) {
            print(message)
        }
    }
}
