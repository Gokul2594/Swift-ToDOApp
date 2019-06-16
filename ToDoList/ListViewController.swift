//
//  ViewController.swift
//  ToDoList
//
//  Created by Gokul Viswanathan on 2019-06-08.
//  Copyright © 2019 Gokul Viswanathan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    var data:[ToDoItem]
    
    init() {
        let item:ToDoItem = ToDoItem(description: "Fake Data")
        self.data = Array(repeating: item, count: 10)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cannot be created from storyboard")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    lazy var titleLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "ToDo List"
        view.textAlignment = .center
        view.font = view.font.withSize(20)
        return view
    }()
    
    lazy var tableView: UITableView! = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        view.tableFooterView = UIView(frame: .zero)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
        view.dataSource = self
        view.delegate = self
        view.register(ToDoItemCell.self, forCellReuseIdentifier: NSStringFromClass(ToDoItemCell.self))
        return view
    }()
    
    override func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        super.updateViewConstraints()
    }
}
extension ListViewController : UITableViewDelegate {
    
}

extension ListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(ToDoItemCell.self),
            for: indexPath
        ) as! ToDoItemCell
        
        cell.toDoItem = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = data[indexPath.row]
        let detailView: DetailViewController = DetailViewController(item: item)
        self.present(detailView, animated: false, completion: nil)
    }
}

