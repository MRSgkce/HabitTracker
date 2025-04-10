
import UIKit
import CoreData
import FSCalendar

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,
FSCalendarDelegate, FSCalendarDataSource {
   
    
    
    var habitList: [Habitdata] = []  // Alışkanlıklar dizisi (Core Data)
    var habitsChecked: [Bool] = [] // Checkbox durumlarını saklamak için dizi
    var progressLabel: UILabel! // İlerleme etiketini ekliyoruz
    var progressBackgroundView: UIView!
    var baslik : UILabel!
    var baslik2 : UILabel!
    // TableView Tanımlaması
    var tableView: UITableView!
    var calendar: FSCalendar!
    
    // CollectionView Tanımlaması
    var collectionView: UICollectionView!
    let items: [(String, UIImage)] = [
        ("Daha iyi bir vücut", UIImage(named: "spor1.png")!),
        ("Mentalini güçlendir", UIImage(named: "mentalimm.png")!) // Alternatif görsel
    ]
    
    let habitManager = HabitManager() // Core Data işlemleri için manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
      //  title = "Habit Tracker"
        
        // ProgressLabel'ı ekleyelim
        setupProgressLabel()
        
        // CollectionView'ı oluşturuyoruz
        setupCollectionView()
        
        // TableView'ı oluşturuyoruz
        setupTableView()
        
        // Core Data'dan alışkanlıkları çek
        fetchHabits()
    }
    
    // Alışkanlıkları Core Data'dan çekiyoruz
    // Alışkanlıkları Core Data'dan çekiyoruz
    func fetchHabits() {
        habitList = habitManager.fetchHabits() // Core Data'dan alışkanlıkları çek
        habitsChecked = Array(repeating: false, count: habitList.count) // Başlangıçta checkbox'ları işaretlemedik
        tableView.reloadData() // TableView'ı güncelle
        updateProgress() // İlerlemeyi güncelle
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchHabits()
    }

    
    // ProgressLabel ve Arka Plan Setup
    func setupProgressLabel() {
        // Arka planı renklendirecek UIView
        progressBackgroundView = UIView()
        progressBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        progressBackgroundView.backgroundColor = UIColor(hex: "#fffbe9") // Arka plan rengi
        progressBackgroundView.layer.cornerRadius = 10 // Köşeleri yuvarlatma
        view.addSubview(progressBackgroundView)
        
        calendar = FSCalendar()
              calendar.translatesAutoresizingMaskIntoConstraints = false
              calendar.delegate = self
              calendar.dataSource = self
              view.addSubview(calendar)
        //calendar.appearance.titleFormat = .short // Kısa tarih formatı (ör. "Apr 2025")
        calendar.appearance.selectionColor = UIColor.blue // Seçilen tarihin arka plan rengini mavi yap
        //calendar.appearance.selectedDateIndicator = .none // Seçilen tarihe özel göstergeyi kaldır
        calendar.setScope(.month, animated: true)  // Sadece ay görünümünü göster
        calendar.scrollDirection = .horizontal // Sadece yatay kaydırmaya izin ver
        calendar.scope = .month  // Ay görünümünü aktif et
        calendar.setScope(.month, animated: true) // Ay görünümüne geçiş
        calendar.scrollDirection = .horizontal // Yalnızca yatay kaydırmaya izin ver
        let today = Date()
        calendar.select(today)  // Bugünü seçili olarak ayarlıyoruz


        baslik = UILabel()
        baslik.translatesAutoresizingMaskIntoConstraints = false
        baslik.font = UIFont.boldSystemFont(ofSize: 27)
        //baslik.font = UIFont.italicSystemFont(ofSize: 30)
        baslik.textColor = .black
        baslik.textAlignment = .left
        baslik.text = "Alışkanlık edin!"
        view.addSubview(baslik)
        
        baslik2 = UILabel()
        baslik2.translatesAutoresizingMaskIntoConstraints = false
        baslik2.font = UIFont.boldSystemFont(ofSize: 20)
        //baslik2.font = UIFont.italicSystemFont(ofSize: 30)
        baslik2.textColor = .black
        baslik2.textAlignment = .left
        baslik2.text = "Yapılacaklar"
        view.addSubview(baslik2)
        
        // İlerleme Etiketi
        progressLabel = UILabel()
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        calendar.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont.boldSystemFont(ofSize: 34) // Fontu büyütüyoruz
        progressLabel.text = "0/0"  // Başlangıçta 0/0 olarak ayarlıyoruz
        progressLabel.textColor = .black
        progressBackgroundView.addSubview(progressLabel) // Label'ı arka planın içine ekliyoruz
        
        // Layout Kısıtlamalarını Aktifleştiriyoruz
        NSLayoutConstraint.activate([
            
            // Baslik ve diğer öğeler arasındaki hiyerarşiyi düzgün bir şekilde kuruyoruz
            baslik.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            baslik.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 10),
            baslik.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            // Calendar için doğru ilişkilendirmeyi yapıyoruz
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendar.heightAnchor.constraint(equalToConstant: 120),
            
            calendar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            calendar.leadingAnchor.constraint(equalTo: progressBackgroundView.trailingAnchor, constant: 20),
            //calendar.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 30),


            // ProgressBackgroundView için doğru kısıtlamayı uyguluyoruz
            progressBackgroundView.topAnchor.constraint(equalTo: baslik.bottomAnchor, constant: 10),
            progressBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           
            progressBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            progressBackgroundView.widthAnchor.constraint(equalToConstant: 30),

            
            // İlerleme etiketinin arka planın içinde konumlandırılması
            progressLabel.topAnchor.constraint(equalTo: progressBackgroundView.topAnchor),
            progressLabel.leftAnchor.constraint(equalTo: progressBackgroundView.leftAnchor),
            progressLabel.rightAnchor.constraint(equalTo: progressBackgroundView.rightAnchor),
            progressLabel.bottomAnchor.constraint(equalTo: progressBackgroundView.bottomAnchor)
        ])
    }
    
    // Progress güncelleme fonksiyonu
    func updateProgress() {
        // İşaretli alışkanlıkları say
        let completed = habitsChecked.filter { $0 }.count
        progressLabel.text = "\(completed)/\(habitList.count)"
    }
    
    // TableView Konfigürasyonu
    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: "habitCell")
        
        // TableView Layout'larını ayarlıyoruz
        NSLayoutConstraint.activate([
            baslik2.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            baslik2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            tableView.topAnchor.constraint(equalTo: baslik2.bottomAnchor, constant: 20), // TableView, CollectionView'in altına yerleştirildi
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 300) // TableView yüksekliği
        ])
    }
    
    /*func didAddHabit(habit: String, frequency: String, detail: String) {
        // Alışkanlık Core Data'ya ekleniyor
        habitManager.addHabit(name: habit, frequency: frequency, detail: detail)
        
        // Yeni alışkanlığı ekledikten sonra alışkanlık listemizi güncelliyoruz
        fetchHabits()  // Bu, Core Data'dan alışkanlıkları çekiyor
        
        // İlerlemeyi güncelliyoruz
        updateProgress()
    }*/



    
    // UITableViewDataSource Metotları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath) as! HabitTableViewCell
        let habit = habitList[indexPath.row]
        cell.habitLabel.text = habit.name
        
        // Satıra tıklanıldığında, tamamlanmış alışkanlık varsa stilini değiştiririz
        if habitsChecked[indexPath.row] {
            cell.habitLabel.textColor = .gray // Tamamlanan alışkanlık yeşil
        } else {
            cell.habitLabel.textColor = .black // Tamamlanmayan alışkanlık siyah
        }
        
        // Checkbox butonuna tıklanma işlemi ekliyoruz
        cell.checkBoxButton.isSelected = habitsChecked[indexPath.row] // Checkbox durumu
        cell.checkBoxButton.addTarget(self, action: #selector(toggleCheckBox(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    // Checkbox butonuna tıklama fonksiyonu
    @objc func toggleCheckBox(sender: UIButton) {
        if let cell = sender.superview?.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Checkbox butonuna tıklanınca alışkanlık durumunu toggle et
            habitsChecked[indexPath.row].toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            updateProgress()
        }
    }
    
    // UITableViewDelegate Metotları
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Satıra tıklanıldığında, tamamlanma durumunu toggle ederiz
        habitsChecked[indexPath.row].toggle() // true veya false olarak değişir
        
        // Satırda yapılan değişikliği güncelle
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        // İlerlemeyi güncelle
        updateProgress()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // İçeriğe göre otomatik boyutlandırma
    }
    
    // UICollectionView Delegate ve DataSource Metotları
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let item = items[indexPath.row]
        cell.iconImageView.image = item.1
        cell.titleLabel.text = item.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        let detailViewController = DetailViewController(itemName: selectedItem.0)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
    func setupCollectionView() {
        // Layout oluşturma
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 200) // Hücre boyutları
        layout.minimumLineSpacing = 20 // Dikey aralık (satır arası boşluk)
        layout.minimumInteritemSpacing = 20 // Yatay aralık (hücre arası boşluk)
        
        // CollectionView oluşturma
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.backgroundColor = .white
        self.view.addSubview(collectionView)
        
        // CollectionView Layout'larını ayarlıyoruz
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: progressBackgroundView.bottomAnchor, constant: 30), // Progress label'in altına yerleştiriyoruz
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            collectionView.heightAnchor.constraint(equalToConstant: 180) // CollectionView yüksekliğini arttırdık
        ])
    }
    
    
    
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*@objc func toggleCheckBox(sender: UIButton) {
        if let cell = sender.superview?.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Checkbox butonuna tıklanınca alışkanlık durumunu toggle et
            habitsChecked[indexPath.row].toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            updateProgress()
        }
    }*/
    

    
    
    
    
    /*// UITableViewDataSource Metotları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath) as! HabitTableViewCell
        cell.habitLabel.text = habitList[indexPath.row]
        
        
        // Satıra tıklanıldığında, tamamlanmış alışkanlık varsa stilini değiştiririz
        if habitsChecked[indexPath.row] {
            cell.habitLabel.textColor = .green // Tamamlanan alışkanlık yeşil
        } else {
            cell.habitLabel.textColor = .black // Tamamlanmayan alışkanlık siyah
        }
        
        // Checkbox butonuna tıklanma işlemi ekliyoruz
        cell.checkBoxButton.isSelected = habitsChecked[indexPath.row] // Checkbox durumu
        cell.checkBoxButton.addTarget(self, action: #selector(toggleCheckBox(sender:)), for: .touchUpInside)
        
        return cell
    }*/

    // Checkbox butonuna tıklama fonksiyonu
   

    /*// UITableViewDelegate Metotları
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Satıra tıklanıldığında, tamamlanma durumunu toggle ederiz
        habitsChecked[indexPath.row].toggle() // true veya false olarak değişir
        
        // Satırda yapılan değişikliği güncelle
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        // İlerlemeyi güncelle
        updateProgress()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // İçeriğe göre otomatik boyutlandırma
    }

    // Yeni alışkanlık eklerken
    func didAddHabit(habit: String) {
        habitList.append(habit)        // Yeni alışkanlığı ekliyoruz
        habitsChecked.append(false)    // Başlangıçta işaretlenmemiş olarak ekliyoruz
        tableView.reloadData()

        // İlerlemeyi güncelle
        updateProgress()
    }

    // UICollectionView Delegate ve DataSource Metotları
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let item = items[indexPath.row]
        cell.iconImageView.image = item.1
        cell.titleLabel.text = item.0
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        let detailViewController = DetailViewController(itemName: selectedItem.0)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
*/
