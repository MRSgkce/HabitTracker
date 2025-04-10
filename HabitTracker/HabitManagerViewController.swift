//
//  HabitManagerViewController.swift
//  HabitTracker
//
//  Created by Mürşide Gökçe on 9.04.2025.
//
import CoreData
import UIKit
import CoreData
import UIKit

class HabitManager {
    
    // Core Data Stack
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Yeni bir alışkanlık eklemek
    func addHabit(name: String, frequency: String, detail: String) {
        let newHabit = Habitdata(context: context)
        newHabit.name = name
        newHabit.frequency = frequency
        newHabit.createdAt = Date() // Alışkanlığın oluşturulma tarihi
        newHabit.details = detail // Alışkanlık açıklaması
        
        do {
            try context.save() // Kaydet
        } catch {
            print("Error saving habit: \(error)")
        }
    }
    
    
    // Core Data'dan alışkanlıkları çekmek
    func fetchHabits() -> [Habitdata] {
        let request: NSFetchRequest<Habitdata> = Habitdata.fetchRequest()
        do {
            let habits = try context.fetch(request)
            return habits
        } catch {
            print("Error fetching habits: \(error)")
            return []
        }
    }
    
    // Günlük alışkanlıkları kaydetme
    func saveDailyHabits(habitsChecked: [Bool], habitList: [Habitdata]) {
        let dailyHabit = DailyHabit(context: context)
        dailyHabit.date = Date() // Günün tarihi
        
        // Seçilen alışkanlıkları günlük alışkanlıklara ekle
        for index in 0..<habitList.count {
            let habit = habitList[index]
            if habitsChecked[index] {
                let habitData = Habitdata(context: context)
                habitData.name = habit.name
                habitData.createdAt = Date()
                habitData.details = habit.details
                habitData.frequency = habit.frequency
                dailyHabit.addToHabits(habitData) // Habitdata'yı DailyHabit'e ekliyoruz
            }
        }
        
        // 24 saat sonra verileri silme işlemi başlatıyoruz
        scheduleDeletionOfDailyHabit(dailyHabit: dailyHabit)
        
        // Veriyi kaydediyoruz
        do {
            try context.save()
            print("Daily Habit saved successfully!")
        } catch {
            print("Error saving daily habit: \(error)")
        }
    }
    
    // 24 saat sonra alışkanlıkları silme işlemi
    func scheduleDeletionOfDailyHabit(dailyHabit: DailyHabit) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 24 * 60 * 60) {  // 24 saat sonra
            self.deleteDailyHabit(dailyHabit: dailyHabit)
        }
    }
    
    func deleteDailyHabit(dailyHabit: DailyHabit) {
        context.delete(dailyHabit)
        
        do {
            try context.save()
            print("DailyHabit deleted successfully.")
        } catch {
            print("Error deleting daily habit: \(error)")
        }
    }

    // Analiz sayfasına aktarılacak günlük alışkanlıkları çekme
    func fetchDailyHabits() -> [DailyHabit] {
        let request: NSFetchRequest<DailyHabit> = DailyHabit.fetchRequest()
        do {
            let dailyHabits = try context.fetch(request)
            return dailyHabits
        } catch {
            print("Error fetching daily habits: \(error)")
            return []
        }
    }
}

 

