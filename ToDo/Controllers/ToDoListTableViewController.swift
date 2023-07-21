//
//  ToDoListTableViewController.swift
//  ToDo
//
//  Created by Dominique Strachan on 7/13/23.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var toDoItems = [Item]()
    //var toDoItems = ["grocery store", "lashes", "build app", "laundry"]
    //user defaults is a dictionary of key value pairs. UserDefaults.plist can store limited amount of data types...best used for one key-value pair
    let defaults = UserDefaults.standard
    //data store in users document folder as customized .plist...model must be encodable
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alertPopup = UIAlertController(title: "Add Item to List", message: "", preferredStyle: .alert)
        
        let actionResponse = UIAlertAction(title: "Add Item", style: .default) { action in
            
            //testing -- data from alert pop up
            //print(textField.text ?? "")
            
            //self.toDoItems.append(textField.text ?? "")
            
            let newItem = Item()
            newItem.name = textField.text ?? "New Item"
            
            self.toDoItems.append(newItem)
            
            //self.defaults.set(self.toDoItems, forKey: "ToDoListsArray")
            
            self.saveToDoItems()
            
            self.tableView.reloadData()
            
        }
        
        alertPopup.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alertPopup.addAction(actionResponse)
        
        present(alertPopup, animated: true, completion: nil)
    }
    
    func saveToDoItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(toDoItems)
            try data.write(to: dataFilePath!)
        } catch {
           print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadToDoItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                toDoItems = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding items array, \(error)")
            }
        }
    }
    
    func setupNavBar() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
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
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let toDoItem = toDoItems[indexPath.row]

        cell.textLabel?.text = toDoItem.name
        
        cell.accessoryType = toDoItem.done == true ? .checkmark : .none
        
//        if toDoItem.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(toDoItems[indexPath.row])
        
//        if toDoItems[indexPath.row].done == false {
//            toDoItems[indexPath.row].done = true
//        } else {
//            toDoItems[indexPath.row].done = false
//        }
        
        toDoItems[indexPath.row].done = !toDoItems[indexPath.row].done
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        self.saveToDoItems()
        
        //deleted because used in saveToDoItems()
        //tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
