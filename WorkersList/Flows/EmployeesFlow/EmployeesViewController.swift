import UIKit

class EmployeesViewController: UIViewController {
    
    private var employees: [Employee] = []
    private var employeesAvatars: [Avatar] = []
    
    private let workersService = WorkersService()
    private let avatarsService = AvatarsService()
    private let tableView = UITableView()
    private let employeeHeader = EmployeeHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupNotifications()
        setUpStyle()
        setUpLayout()
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            DispatchQueue.main.async {
                self.employeeHeader.showConnection()
            }
        } else {
            DispatchQueue.main.async {
                self.showAlert()
                self.employeeHeader.showDisconnection()
            }
        }
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    private func showAlert() {

        let alert = UIAlertController(title: "No Internet", message: "This app requires wifi/internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default ))
        present(alert, animated: true, completion: nil)
    }
    
    private func setUpStyle() {
        
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableHeaderView = employeeHeader
        tableView.separatorStyle = .none
    }
    
    private func setUpLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        employeeHeader.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        employeeHeader.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func loadData() {
        
        workersService.fetchResultsFromApi { [weak self] result in
            switch result {
            case .success(let workersList):
                self?.employeeHeader.setCompanyName(name: workersList.company.name)
                self?.employees = workersList.company.employees.sorted { employeelhs, employeerhs in
                    
                    employeelhs.name < employeerhs.name
                }
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        employeesAvatars = avatarsService.getAvatarsData()
    }
}

// MARK: TableViewDataSource

extension EmployeesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EmployeeCell.reuseIdentifier, for: indexPath) as! EmployeeCell
        let employee = employees[indexPath.row]
        let avatar = employeesAvatars.indices.contains(indexPath.row) ? employeesAvatars[indexPath.row] : nil
        cell.configure(employee: employee, avatar: avatar)
        return cell
        
    }
}
