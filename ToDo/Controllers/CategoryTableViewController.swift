//
//  CategoryTableViewController.swift
//  ToDo
//
//  Created by Dominique Strachan on 7/24/23.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()

    //var categories = [Category]()
    var categories: Results<Category>?
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        loadCategories()
    }
    
    
    @IBAction func addCategoryButtonTapped(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
//            let newCategory = Category(context: self.context)
//            newCategory.title = textField.text ?? "New Category"
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            //no need to append new objects because realm container auto-updates
//            self.categories.append(newCategory)
            
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Create New Category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func setupNavBar() {
        
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation controller does not exist.")
        }
        
        navBar.prefersLargeTitles = true
        
        navBar.tintColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(red: 60/255, green: 77/255, blue: 136/255, alpha: 1.0)
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    func deleteCategory(category: Category) {
        //context.delete(category)
        //saveCategories()
    }
    
    func save(category: Category) {
        
        do{
            //try context.save()
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category: \(error)")
        }

        tableView.reloadData()
    }
    
    func loadCategories() {
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetching categories from context: \(error)")
//        }
//
        
        //let categories = realm.objects(Category.self)
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            //deleteCategory(category: categories[indexPath.row])
            
            //categories.remove(at: indexPath.row)
            
            if let category = categories?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(category)
                    }
                } catch {
                    print("Error deleting category: \(error)")
                }
            }
            
            self.tableView.reloadData()
        }
   
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        //let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoToDoList" , sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = categories?[indexPath.row]
        }
    }

}
