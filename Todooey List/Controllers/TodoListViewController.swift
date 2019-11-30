//
//  ViewController.swift
//  Todooey List
//
//  Created by Aman Virani on 30/11/19.
//  Copyright © 2019 Aman Virani. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            
            itemArray = items
            
        }
    */
        let newItem = Item()
        newItem.title = "Find Arsh"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Learn to code"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
    }

    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
      //  cell.accessoryType = item.done == true ? .checkmark : .none
        //OR
        cell.accessoryType = item.done ? .checkmark : .none
        // OR another long way
        /*
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        */
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        // this ! makes the true value false and the False value true by only one code (reverseing)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       /* if itemArray[indexPath.row].done == false {
           itemArray[indexPath.row].done = true
        } else {
            itemArray[indexPath.row].done = false
        }
        */
       /*
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        */
        
        tableView.reloadData()
        //to de select so the color becomes white
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todooey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What will happen once the user clicks the add item button on our UIAlert
            let newItem = Item()
            newItem.title = textField.text!
            
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            // extending the alertTextField scope outside the closure
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        // to present alert
        present(alert, animated: true, completion: nil)
    }
    
}

