//
//  DetailsViewController.swift
//  HabitTracker
//
//  Created by Mürşide Gökçe on 8.04.2025.
//

import UIKit

class DetailViewController: UIViewController {
    var itemName: String
    
    init(itemName: String) {
        self.itemName = itemName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let label = UILabel()
        label.text = "You selected \(itemName)"
        label.frame = CGRect(x: 100, y: 200, width: 300, height: 50)
        view.addSubview(label)
    }
}
