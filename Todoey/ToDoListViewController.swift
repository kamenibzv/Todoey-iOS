//
//  ViewController.swift
//  Todoey
//
//  Created by Kameni Ngahdeu on 1/5/19.
//  Copyright © 2019 Kaydabi. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemsToDo =  [Item]()
    
    // Filepath to use for NSCoder
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
        
//        // Items to add to the to do list
//        let newItem = Item(toDoTitle: "Get Food")
//        let newItem1 = Item(toDoTitle: "Text p")
//        let newItem2 = Item(toDoTitle: "Go home")
//        let newItem3 = Item(toDoTitle: "Chat with them")
//
//        itemsToDo.append(newItem)
//        itemsToDo.append(newItem1)
//        itemsToDo.append(newItem2)
//        itemsToDo.append(newItem3)
        
    }
    
    //MARK - Tableview Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsToDo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemsToDo[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Checks and set whether or not the cell was selected
        
        cell.accessoryType = item.done ? .checkmark : .none
    
        return cell
        
    }
    
    //MARK - Tableview Delegate methods. What happens when a cell is pressed
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Sets the done value if the cell was clicked
        itemsToDo[indexPath.row].done = !itemsToDo[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items. When the add button is created

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What happens when the add item button is clicked
            
            let newItem = Item(toDoTitle: textField.text!)
            
            self.itemsToDo.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert , animated: true, completion: nil)
    }
    
    //MARK - Create the encoders and decoders
    
    func saveItems() {
        
        // encoding the data and writing it to the p list

        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemsToDo)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding array: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                
            itemsToDo = try decoder.decode([Item].self, from: data)
                
            } catch {
                print("Error encoding array: \(error)")
            }
        }

    }
}

