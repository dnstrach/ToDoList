//
//  ToDoItem.swift
//  ToDo
//
//  Created by Dominique Strachan on 7/25/23.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //inverse relationship
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
