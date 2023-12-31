//
//  ToDoListTableViewController.swift
//  ToDo
//
//  Created by Dominique Strachan on 7/13/23.
//

import UIKit
//import CoreData
import RealmSwift

class ToDoListTableViewController: UITableViewController {
    
    var realm = try! Realm()
    //var toDoItems = [ToDoItem]()
    var toDoItems: Results<ToDoItem>?
    
    var selectedCategory: Category? {
        didSet {
            //loadToDoItems()
      
        }
    }
    
    //var toDoItems = [Item]()
    //var toDoItems = ["grocery store", "lashes", "build app", "laundry"]
    //user defaults is a dictionary of key value pairs. UserDefaults.plist can store limited amount of data types...best used for one key-value pair
    //let defaults = UserDefaults.standard
    //data store in users document folder as customized .plist...model must be encodable
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //itemsTableView.reloadData()
        
        //shows file path where items are being saved
        //print(dataFilePath)
      
        
//        let newItem = Item()
//        newItem.name = "udemy"
//        toDoItems.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.name = "gym"
//        toDoItems.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.name = "buy card"
//        toDoItems.append(newItem3)
        
        loadToDoItems()
        

//        if let items = defaults.array(forKey: "ToDoListsArray") as? [String] {
//            toDoItems = items
//        }
        
//        if let items = defaults.array(forKey: "ToDoListsArray") as? [Item] {
//            toDoItems = items
//        }
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory!.name
    }
    
    //MARK: - Create
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alertPopup = UIAlertController(title: "Add Item to List", message: "", preferredStyle: .alert)
        
        let actionResponse = UIAlertAction(title: "Add Item", style: .default) { action in
            
            //testing -- data from alert pop up
            //print(textField.text ?? "")
            
            //self.toDoItems.append(textField.text ?? "")
            
//            let newItem = ToDoItem(context: self.context)
//
//            //let newItem = Item()
//            newItem.name = textField.text ?? "New Item"
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = ToDoItem()
                        newItem.name = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items: \(error)")
                }
            }
        
//
//            self.toDoItems.append(newItem)
//
//            //self.defaults.set(self.toDoItems, forKey: "ToDoListsArray")
            
            //self.saveToDoItems()
            
            self.tableView.reloadData()
            
        }
        
        alertPopup.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alertPopup.addAction(actionResponse)
        
        present(alertPopup, animated: true, completion: nil)
    }
    
    func deleteItem(toDoItem: ToDoItem) {
//        context.delete(toDoItem)
//        saveToDoItems()
    }
    
//    func saveToDoItems() {
//        //let encoder = PropertyListEncoder()
//
//        do {
//            // context.save()
//
////            let data = try encoder.encode(toDoItems)
////            try data.write(to: dataFilePath!)
//        } catch {
//            print("Error saving context: \(error)")
//
////           print("Error encoding item array, \(error)")
//        }
//
//        self.tableView.reloadData()
//    }
    
    //core data parameters: with request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest(), predicate: NSPredicate? = nil
    func loadToDoItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//                toDoItems = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding items array, \(error)")
//            }
//        }


//        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory!.title!)
//
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }


//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])

        //let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
//        do {
//        toDoItems = try context.fetch(request)
//        } catch {
//            print("Error loading/fetching items from context: \(error)")
//        }

        toDoItems = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.name
            
            cell.accessoryType = item.done ? .checkmark : .none
            print(item)
        } else {
            cell.textLabel?.text = "No items added"
        }

        
//        if toDoItem.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
//        if toDoItems[indexPath.row].done == false {
//            toDoItems[indexPath.row].done = true
//        } else {
//            toDoItems[indexPath.row].done = false
//        }
        
       // toDoItems[indexPath.row].done = !toDoItems[indexPath.row].done
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        //self.saveToDoItems()
        
        //deleted because used in saveToDoItems()
        //tableView.reloadData()
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status: \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
//            //order matters must remove items from core data first or else will affect index numbers of array from cells
//            deleteItem(toDoItem: toDoItems?[indexPath.row])
//
//            toDoItems.remove(at: indexPath.row)
            
            if let item = toDoItems?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                    }
                } catch {
                    print("Error deleting item: \(error)")
                }
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }

}

//MARK: - Search Bar Methods
extension ToDoListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //let request :NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()

        //testing
        //print(searchBar.text!)

        //to query CoreData use NSPredicate
        //[cd] - case insensitivity
        //let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)

        //request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

//        do {
//        toDoItems = try context.fetch(request)
//        } catch {
//            print("Error loading/fetching items from context: \(error)")
//        }
//
//        tableView.reloadData()

        //loadToDoItems(with: request, predicate: predicate)
        
        toDoItems = toDoItems?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadToDoItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
