//
//  customViewController.swift
//  HabitTracker
//
//  Created by Mürşide Gökçe on 9.04.2025.
//

import UIKit




import UIKit

class CustomLabel: UILabel {

    // Font, boyut ve stil gibi parametreleri burada tanımlayabilirsiniz
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // Ortak başlatma işlemleri
    private func commonInit() {
        // Fontu Roboto-Regular olarak ayarla
        self.font = UIFont(name: "Roboto-Regular", size: 18)
        self.textColor = .black  // Varsayılan renk siyah
        self.textAlignment = .left  // Yazıyı sola hizala
    }

    // Custom font uygulama fonksiyonu
    func applyCustomFont(isBold: Bool, fontSize: CGFloat) {
        let fontName = isBold ? "Roboto-Bold" : "Roboto-Regular"
        self.font = UIFont(name: fontName, size: fontSize)
    }
}
