import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  HabitAddDelegate{
    var habitList: [String] = []  // Alışkanlıklar dizisi
    
    // TableView Tanımlaması
    var tableView: UITableView!
    
   
    var habitsChecked: [Bool] = [false, false, false, false, false] // Checkbox durumlarını saklamak için dizi

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Habit Tracker"
        
        // TableView'ı oluşturuyoruz
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // TableView Konfigürasyonu
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: "habitCell")
        
        // TableView Layout'larını ayarlıyoruz
        setupTableViewConstraints()
    }

    // TableView Constraint Ayarları
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 2),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // UITableViewDataSource Metotları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath) as! HabitTableViewCell
        //cell.textLabel?.text = habits[indexPath.row]
        cell.habitLabel.text = habitList[indexPath.row]
        cell.checkBoxButton.isSelected = habitsChecked[indexPath.row] // Checkbox durumunu ayarlama
        return cell
    }

    // UITableViewDelegate Metotları
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Kullanıcı bir satıra tıkladığında, checkbox durumunu değiştir
        habitsChecked[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func didAddHabit(habit: String) {
            habitList.append(habit)
            tableView.reloadData()  // TableView'ı güncelle
        }
}
