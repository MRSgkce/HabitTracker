//
//  HabitAddViewController.swift
//  HabitTracker
//
//  Created by Mürşide Gökçe on 6.04.2025.
//

import UIKit
import UIKit
import UIKit

protocol HabitAddDelegate: AnyObject {
    func didAddHabit(habit: String)
}

class HabitAddViewController: UIViewController {
    
    weak var delegate: HabitAddDelegate?  // Delegate
    
    var habitTextField: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        habitTextField.text = " "
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        view.backgroundColor = .white
        title = "Add Habit"
        
        // Text field
        habitTextField = UITextField()
        habitTextField.borderStyle = .roundedRect
        habitTextField.placeholder = "Enter habit"
        habitTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(habitTextField)
        
        // Button to add habit
        let addButton = UIButton(type: .system)
        addButton.setTitle("Save Habit", for: .normal)
        addButton.addTarget(self, action: #selector(addHabitTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        // Constraints for text field and button
        NSLayoutConstraint.activate([
            habitTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            habitTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            habitTextField.widthAnchor.constraint(equalToConstant: 200),
            
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: habitTextField.bottomAnchor, constant: 20)
        ])
    }
    
    @objc func addHabitTapped() {
        if let habit = habitTextField.text, !habit.isEmpty {
            delegate?.didAddHabit(habit: habit)  // Delegate metodunu çağır
            navigationController?.popViewController(animated: true)  // Geri dön
        } else {
            // Eğer kullanıcı boş girerse hata mesajı göster
            let alert = UIAlertController(title: "Error", message: "Please enter a habit", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

}
