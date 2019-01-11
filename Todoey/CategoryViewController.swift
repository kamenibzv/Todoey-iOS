//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Kameni Ngahdeu on 1/10/19.
//  Copyright © 2019 Kaydabi. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    // Context to save the Category to the database
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    //MARK - Tableview Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        

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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }

    @IBAction func categoryAddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // What happens when the add item button is clicked
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert , animated: true, completion: nil)
        
    }
    
    //MARK - Save and load items
    func saveCategories() {
        // Commit our context to permanent storage in persistentContainer
        do {
            try context.save()
        } catch {
            print("Saving context error: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do {
            
            categories = try context.fetch(request)
            
        } catch {
            print("Error fetching data: \(error)")
        }
        
        tableView.reloadData()
    }
}
