//
//  HabitTableViewCell.swift
//  HabitTracker
//
//  Created by Mürşide Gökçe on 6.04.2025.
//
import UIKit
import UIKit
import SnapKit

class HabitTableViewCell: UITableViewCell {
    var checkBoxButton: UIButton!
    var habitLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Checkbox butonunun konfigürasyonu
        checkBoxButton = UIButton(type: .custom)
        checkBoxButton.setImage(UIImage(systemName: "circle"), for: .normal) // Boş daire (checkbox)
        checkBoxButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected) // Seçili daire (checkbox)
        checkBoxButton.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false

        // Alışkanlık ismi için label ekliyoruz
        habitLabel = UILabel()
        habitLabel.textColor = .white
        habitLabel.font = UIFont.systemFont(ofSize: 16)
        habitLabel.translatesAutoresizingMaskIntoConstraints = false

        // Checkbox ve Label ekliyoruz
        contentView.addSubview(checkBoxButton)
        contentView.addSubview(habitLabel)
        
        /*// SnapKit ile constraint ekliyoruz
        checkBoxButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15) // Sol kenara 15 px mesafe
            make.centerY.equalToSuperview() // Yatayda ve dikeyde ortalanacak
            make.width.height.equalTo(30) // Boyut 30x30
        }

        habitLabel.snp.makeConstraints { make in
            make.left.equalTo(checkBoxButton.snp.right).offset(50) // Checkbox'tan 15 px sağa
            make.centerY.equalToSuperview() // Yatayda ve dikeyde ortalanacak
            make.right.equalToSuperview().offset(-15) // Sağ kenara 15 px mesafe
        }*/
        
        NSLayoutConstraint.activate([
            checkBoxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            checkBoxButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            checkBoxButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 30),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            habitLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 10),
            habitLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            habitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            habitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 25),
            habitLabel.widthAnchor.constraint(equalToConstant: 30),
            habitLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func checkBoxTapped() {
        checkBoxButton.isSelected.toggle() // Butonun durumunu değiştir
    }
}
