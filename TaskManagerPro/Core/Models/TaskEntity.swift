//
//  TaskEntity.swift
//  TaskManagerPro
//
//  Created by oscar perdana on 03/01/26.
//

//import Foundation
//import CoreData
//
//final class TaskEntity: NSManagedObject {
//    @NSManaged var id: UUID
//    @NSManaged var title: String
//    @NSManaged var details: String
//    @NSManaged var priority: String
//    @NSManaged var createdAt: Date
//    @NSManaged var updatedAt: Date
//    @NSManaged var isCompleted: Bool
//    
//    override func awakeFromInsert() {
//        super.awakeFromInsert()
//        setPrimitiveValue(Date.now, forKey: "createdAt")
//        setPrimitiveValue(Date.now, forKey: "updatedAt")
//        setPrimitiveValue(false, forKey: "isCompleted")
//    }
//}
