import UIKit
import Foundation
import UIKit
import UIKit
import Foundation

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // TabBar'ın tint rengini sıfırlıyoruz
        self.tabBar.tintColor = nil
        
        // View Controller'ları oluşturuyoruz
        let anaVC = ViewController()
        let secondVC = SecondViewController()
        let ekleVC = HabitAddViewController()
        let analizVC = AnalizViewController()
   
        let addHabitNavController = UINavigationController(rootViewController: ekleVC)
        
        
        // Delegate bağlantısını yapıyoruz
       
            ekleVC.delegate = anaVC
        

        
        // Her ViewController'a bir tab bar item ekliyoruz
        // Her ViewController'a bir tab bar item ekliyoruz
        let image0 = UIImage(named: "home.png")!.withRenderingMode(.alwaysOriginal)
        let resizedImage0 = resizeImage(image: image0, targetSize: CGSize(width: 50, height: 50))
        anaVC.tabBarItem = UITabBarItem(title: "home", image: resizedImage0.withRenderingMode(.alwaysOriginal), tag: 0)
        
        let image3 = UIImage(named: "analiz.png")!.withRenderingMode(.alwaysOriginal)
        let resizedImage3 = resizeImage(image: image3, targetSize: CGSize(width: 50, height: 50))
        analizVC.tabBarItem = UITabBarItem(title: "Analiz", image: resizedImage3.withRenderingMode(.alwaysOriginal), tag: 0)
        
        let image2 = UIImage(named: "add.png")!.withRenderingMode(.alwaysOriginal)
        let resizedImage2 = resizeImage(image: image2, targetSize: CGSize(width: 70, height: 70))
        ekleVC.tabBarItem = UITabBarItem(title: "Yeni alışkanlık ekle", image: resizedImage2.withRenderingMode(.alwaysOriginal), tag: 1)
        
        // Resmi orijinal haliyle ekle
        let image = UIImage(named: "motivation.png")!.withRenderingMode(.alwaysOriginal)
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))
        secondVC.tabBarItem = UITabBarItem(title: "Motivation", image: resizedImage.withRenderingMode(.alwaysOriginal), tag: 2)
        
       
        
        // TabBarController'a view controller'ları ekliyoruz
        viewControllers = [anaVC, analizVC, ekleVC, secondVC]
        
        
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Boyutları doğru şekilde hesapla
        let newSize = CGSize(width: size.width * min(widthRatio, heightRatio),
                             height: size.height * min(widthRatio, heightRatio))
        
        // Yeni boyut ile resminizi yeniden oluşturun
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0) // Şeffaf arka plan
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
