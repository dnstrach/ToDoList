//
//  AppDelegate.swift
//  ToDo
//
//  Created by Dominique Strachan on 7/13/23.
//

import UIKit
//import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        //file path for realm database
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        
//        let data = Data()
//        data.name = "Dominique"
//        data.age = 26
        
        //initializing realm
        do {
            let realm = try Realm()
//            try realm.write {
//                realm.add(data)
//            }
        } catch {
            print("Error initializing new realm: \(error)")
        }
        
        return true
    }
    
    //entering home screen or a different app
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }
    
    //force quit
    //installed update
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }
    
    
    //MARK: - Core Data Stack

//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "ToDoManager")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    //Core Data = SQLlite database
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        //context is temporary space that can be saved into Core Data
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }


}

