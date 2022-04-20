//
//  PersistentContainer.swift
//  ToDoTask (HW 13) Core Data
//
//  Created by Алексей Синяговский on 20.04.2022.
//


import UIKit

class PersistentContainer {
    
    static let shared = PersistentContainer()
    
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
}
