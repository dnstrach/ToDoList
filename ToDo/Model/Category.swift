//
//  Category.swift
//  ToDo
//
//  Created by Dominique Strachan on 7/25/23.
//

import Foundation
import RealmSwift

//inheriting object allows category to be saved into Realm
class Category: Object {
    //dynamic so variable can be changed/saved during runtime
    @objc dynamic var name: String = ""
    let items = List<ToDoItem>()
}
