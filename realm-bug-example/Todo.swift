//
//  Todo.swift
//  realm-bug-example
//
//  Created by Griffin Meyer on 7/7/23.
//

import Foundation
import RealmSwift

class Todo: Object, ObjectKeyIdentifiable {
   @Persisted(primaryKey: true) var _id: ObjectId
   @Persisted var name: String = ""
   @Persisted var status: String = ""
   @Persisted var ownerId: String
   convenience init(name: String, ownerId: String) {
       self.init()
       self.name = name
       self.ownerId = ownerId
   }
}
