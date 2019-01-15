//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Kameni Ngahdeu on 1/10/19.
//  Copyright © 2019 Kaydabi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    
    // Create a Realm instance
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //MARK - Tableview Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category"

        return cell
    }

    //MARK - Tableview Delegate methods. What happens when the user clicks
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Take user to the Item page
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get the destination VC
        let destinationVC = segue.destination as! ToDoListViewController
        
        //Grab the category that belongs to the celected cell and get the Items for that
        if let indexPath =  tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    @IBAction func categoryAddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What happens when the add item button is clicked
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.saveCategories(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert , animated: true, completion: nil)
        
    }
    
    //MARK - Save and load items
    func saveCategories(category: Category) {
        // Commit our context to permanent storage in persistentContainer
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Saving context error: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}
