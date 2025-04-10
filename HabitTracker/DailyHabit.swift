//
//  File.swift
//  HabitTracker
//
//  Created by Mürşide Gökçe on 10.04.2025.
//
import Foundation
import CoreData

@objc(DailyHabit)
public class DailyHabit: NSManagedObject {

    // Bu sınıf otomatik olarak Xcode tarafından oluşturulabilir
}

extension DailyHabit {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyHabit> {
        return NSFetchRequest<DailyHabit>(entityName: "DailyHabit")
    }

    @NSManaged public var date: Date?
    @NSManaged public var habits: NSSet?  // To-many relationship, bir DailyHabit birden fazla Habitdata içerebilir
    
    // İlişki ekleme metodu
    @objc(addHabitsObject:)
    @NSManaged public func addToHabits(_ value: Habitdata)
    
    // İlişki silme metodu
    @objc(removeHabitsObject:)
    @NSManaged public func removeFromHabits(_ value: Habitdata)
    
    // Tüm alışkanlıkları silme metodu
    @objc(addHabits:)
    @NSManaged public func addToHabits(_ values: NSSet)
    
    // Tüm alışkanlıkları çıkarma metodu
    @objc(removeHabits:)
    @NSManaged public func removeFromHabits(_ values: NSSet)
}
