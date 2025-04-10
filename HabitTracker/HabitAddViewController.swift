import UIKit
import CoreData
/*
protocol HabitAddDelegate: AnyObject {
    func didAddHabit(habit: String, frequency: String, detail: String)
}

class HabitAddViewController: UIViewController {
    
    weak var delegate: HabitAddDelegate?  // Delegate
    
    var habitTextField: UITextField!
    var frequencyControl: UISegmentedControl!
    var detailTextView: UITextView!
    
    let habitManager = HabitManager() // Core Data ile işlem yapacak manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Add Habit"
        
        // Habit name text field
        habitTextField = UITextField()
        habitTextField.borderStyle = .roundedRect
        habitTextField.placeholder = "Enter habit"
        habitTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(habitTextField)
        
        // Frequency selection (Every Day, Every 2 Days, Every 3 Days)
        frequencyControl = UISegmentedControl(items: ["Every Day", "Every 2 Days", "Every 3 Days"])
        frequencyControl.selectedSegmentIndex = 0 // Default to "Every Day"
        frequencyControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(frequencyControl)
        
        // Habit description (detail)
        detailTextView = UITextView()
        detailTextView.layer.borderColor = UIColor.gray.cgColor
        detailTextView.layer.borderWidth = 1.0
        detailTextView.layer.cornerRadius = 5
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.text = "Enter habit details here..."
        view.addSubview(detailTextView)
        
        // Save button
        let addButton = UIButton(type: .system)
        addButton.setTitle("Save Habit", for: .normal)
        addButton.addTarget(self, action: #selector(addHabitTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        // Constraints for the views
        NSLayoutConstraint.activate([
            habitTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            habitTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            habitTextField.widthAnchor.constraint(equalToConstant: 250),
            
            frequencyControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            frequencyControl.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 20),
            frequencyControl.widthAnchor.constraint(equalToConstant: 250),
            
            detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailTextView.topAnchor.constraint(equalTo: frequencyControl.bottomAnchor, constant: 20),
            detailTextView.widthAnchor.constraint(equalToConstant: 250),
            detailTextView.heightAnchor.constraint(equalToConstant: 100),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: detailTextView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func addHabitTapped() {
        if let habitName = habitTextField.text, !habitName.isEmpty,
           let habitDetail = detailTextView.text, !habitDetail.isEmpty {
            
            // Get selected frequency
            let frequency: String
            switch frequencyControl.selectedSegmentIndex {
            case 0:
                frequency = "Every Day"
            case 1:
                frequency = "Every 2 Days"
            case 2:
                frequency = "Every 3 Days"
            default:
                frequency = "Every Day"
            }
            
            // Add habit to Core Data
            habitManager.addHabit(name: habitName, frequency: frequency, detail: habitDetail)
            
            // Call delegate method and go back
            delegate?.didAddHabit(habit: habitName, frequency: frequency, detail: habitDetail)
            navigationController?.popViewController(animated: true)
        } else {
            // If the user didn't enter a habit name or details
            let alert = UIAlertController(title: "Error", message: "Please enter a habit and details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

*/

import UIKit
import UserNotifications


protocol HabitAddDelegate: AnyObject {
    func didAddHabit(habit: String, frequency: String, detail: String)
}
class HabitAddViewController: UIViewController {
    
    weak var delegate: HabitAddDelegate?
    
    var habitTextField: UITextField!
    var frequencyControl: UISegmentedControl!
    var detailTextView: UITextView!
    
    let habitManager = HabitManager() // Core Data işlemleri için manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        //title = "Add Habit"
        
        // Habit name text field
        habitTextField = UITextField()
        habitTextField.borderStyle = .roundedRect
        habitTextField.placeholder = "Enter habit"
        habitTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(habitTextField)
        
        // Frequency selection (Every Day, Every 2 Days, Every 3 Days)
        frequencyControl = UISegmentedControl(items: ["Every Day", "Every 2 Days", "Every 3 Days"])
        frequencyControl.selectedSegmentIndex = 0 // Default to "Every Day"
        frequencyControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(frequencyControl)
        
        // Habit description (detail)
        detailTextView = UITextView()
        detailTextView.layer.borderColor = UIColor.gray.cgColor
        detailTextView.layer.borderWidth = 1.0
        detailTextView.layer.cornerRadius = 5
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.text = "Enter habit details here..."
        view.addSubview(detailTextView)
        
        // Save button
        let addButton = UIButton(type: .system)
        addButton.setTitle("Save Habit", for: .normal)
        addButton.addTarget(self, action: #selector(addHabitTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        // Constraints for the views
        NSLayoutConstraint.activate([
            habitTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            habitTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            habitTextField.widthAnchor.constraint(equalToConstant: 250),
            
            frequencyControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            frequencyControl.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 20),
            frequencyControl.widthAnchor.constraint(equalToConstant: 250),
            
            detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailTextView.topAnchor.constraint(equalTo: frequencyControl.bottomAnchor, constant: 20),
            detailTextView.widthAnchor.constraint(equalToConstant: 250),
            detailTextView.heightAnchor.constraint(equalToConstant: 100),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: detailTextView.bottomAnchor, constant: 20)
        ])
    }
    /*
    @objc func addHabitTapped() {
        if let habitName = habitTextField.text, !habitName.isEmpty,
           let habitDetail = detailTextView.text, !habitDetail.isEmpty {
            
            // Get selected frequency
            let frequency: String
            switch frequencyControl.selectedSegmentIndex {
            case 0:
                frequency = "Every Day"
                scheduleDailyNotification() // Bildirim her gün gönderilecek
            case 1:
                frequency = "Every 2 Days"
            case 2:
                frequency = "Every 3 Days"
            default:
                frequency = "Every Day"
            }
            
            // Add habit to Core Data
            habitManager.addHabit(name: habitName, frequency: frequency, detail: habitDetail)
            
            // Call delegate method and go back
            delegate?.didAddHabit(habit: habitName, frequency: frequency, detail: habitDetail)
            navigationController?.popViewController(animated: true)
        } else {
            // If the user didn't enter a habit name or details
            let alert = UIAlertController(title: "Error", message: "Please enter a habit and details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    */
    @objc func addHabitTapped() {
        if let habitName = habitTextField.text, !habitName.isEmpty,
           let habitDetail = detailTextView.text, !habitDetail.isEmpty {
            
            // Get selected frequency
            let frequency: String
            switch frequencyControl.selectedSegmentIndex {
            case 0:
                frequency = "Every Day"
                scheduleDailyNotification() // Bildirim her gün gönderilecek
            case 1:
                frequency = "Every 2 Days"
            case 2:
                frequency = "Every 3 Days"
            default:
                frequency = "Every Day"
            }
            
            // Alışkanlık Core Data'ya kaydediliyor
            habitManager.addHabit(name: habitName, frequency: frequency, detail: habitDetail)
            
            // Geri dönülüyor (delegasyon kullanılmadan sadece verinin kaydedilmesi sağlanıyor)
            navigationController?.popViewController(animated: true)
        } else {
            // Hata mesajı
            let alert = UIAlertController(title: "Error", message: "Please enter a habit and details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    /*
    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = "Don't forget to complete your habit for today!"
        content.sound = .default
        
        // Şu anki tarih ve saati alıyoruz
        let currentDate = Date()
        
        // Şu anki zamanı Calendar kullanarak alıyoruz
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.hour, .minute], from: currentDate)
        
        // Şu anki dakikaya 1 dakika ekliyoruz
        dateComponents.minute! += 1  // 1 dakika sonrasına ayarlıyoruz
        
        // Bildirim zamanını tetiklemek için trigger oluşturuyoruz
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Bildirim talebini oluşturuyoruz
        let request = UNNotificationRequest(identifier: "dailyHabitReminder", content: content, trigger: trigger)
        
        // Bildirimi planlıyoruz
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")  // Hata varsa konsola yazdırırız
            } else {
                print("Notification scheduled!")  // Bildirim planlandığında konsola yazdırılır
            }
        }
    }*/

  

    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Habit Reminder"
        content.body = "Don't forget to complete your habit for today!"
        content.sound = .default
        
        // Bildirim zamanı: her gün saat 11:00'de
        var dateComponents = DateComponents()
        dateComponents.hour = 11  // Saat 11:00
        dateComponents.minute = 0  // Dakika 0
        dateComponents.second = 0  // Saniye 0
        
        // Tekrarlayan bildirim (Her gün saat 11:00'de)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Bildirim talebini oluşturuyoruz
        let request = UNNotificationRequest(identifier: "dailyHabitReminder", content: content, trigger: trigger)
        
        // Bildirimi planlıyoruz
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")  // Hata varsa konsola yazdırırız
            } else {
                print("Notification scheduled for 11:00 AM daily!")  // Bildirim planlandığında konsola yazdırılır
            }
        }
    }


}

