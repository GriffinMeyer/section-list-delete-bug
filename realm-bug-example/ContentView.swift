//
//  ContentView.swift
//  realm-bug-example
//
//  Created by Griffin Meyer on 7/7/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedSectionedResults(Todo.self, sectionKeyPath: \.status) var todos
    
    func delete(at offsets: IndexSet, section: ResultsSection<String, Todo>){
        let deleteList = offsets.map { index in
            section[index]
        }
        let realm = try! Realm()
        try! realm.write {
            for todo in deleteList {
                realm.delete(todo)
            }
            
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(todos) { section in
                    Section(header: Text(section.key)) {
                        ForEach(section) { todo in
                            Text(todo.name)
                        }
                        .onDelete{
                            delete(at: $0, section: section)
                        }
                    }
                    
                }
            }
            Button("Add Ready Todo"){
                let realm = try! Realm()
                try! realm.write {
                    let todo = Todo(name: "New", ownerId: "123")
                    todo.status = "ready"
                    realm.add(todo)
                }
            }
            
            Button("Add Blocked Todo"){
                let realm = try! Realm()
                try! realm.write {
                    let todo = Todo(name: "New", ownerId: "123")
                    todo.status = "Blocked"
                    realm.add(todo)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
