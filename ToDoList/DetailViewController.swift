//
//  DetailViewController.swift
//  ToDoList/Users/gokulviswanathan/Desktop/dev/IphoneDev/ToDoList/ToDoList/DetailViewController.swift
//
//  Created by Gokul Viswanathan on 2019-06-16.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    
    var item: ToDoItem
    var listManager: ToDoListManager
    
    init(item: ToDoItem){
        self.item = item
        listManager = ToDoListManager()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("cannot be created from storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(descriptionLabel)
        view.addSubview(dateCreatedLabel)
        view.addSubview(completedSwitch)
        view.addSubview(backButton)
        view.addSubview(dateCompletedLabel)
        
        descriptionLabel.text = item.description
        dateCreatedLabel.text = item.dateCreatedAsString()
        completedSwitch.isOn = item.completed
        dateCompletedLabel.text = item.dateUpdatedAsString()
        
        view.setNeedsUpdateConstraints()
    }
    
    lazy var descriptionLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var dateCreatedLabel: UILabel! = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.textAlignment = .left
        view.font = view.font.withSize(20)
        
        return view
    }()
    
    lazy var completedSwitch: UISwitch! = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOn = self.item.completed
        
        view.addTarget(self, action: #selector(updateCompletedDate), for: UIControl.Event.valueChanged)
        
        return view
    }()
    
    @objc func updateCompletedDate(mySwitch: UISwitch){
        if(mySwitch.isOn){
            self.item.completed = true
            self.item.dateUpdated = Date()
            listManager.updateItem(item: self.item)
            dateCompletedLabel.text = self.item.dateUpdatedAsString()
        }
        else{
            self.item.completed = false
            self.item.dateUpdated = Date()
            listManager.updateItem(item: self.item)
            dateCompletedLabel.text = self.item.dateUpdatedAsString()
        }
    }
    
    lazy var backButton: UIButton! = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Back", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .black
        
        view.addTarget(self, action: #selector(onBackClicked), for: .touchDown)
        
        return view
    }()
    
    lazy var dateCompletedLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = view.font.withSize(20)

        return view
    }()
    
    @objc func onBackClicked() {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        backButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50).isActive = true
        backButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        dateCreatedLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        dateCompletedLabel.topAnchor.constraint(equalTo: dateCreatedLabel.bottomAnchor, constant: 10).isActive = true

        dateCompletedLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10).isActive = true
        
        completedSwitch.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30).isActive = true
        completedSwitch.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10).isActive = true
        
        super.updateViewConstraints()
    }
}
