//
//  ViewController.swift
//  WorkersList
//
//  Created by Людмила Долонтаева on 24.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    var employees: [Employee] = []
    var employeesAvatars: [Avatar] = []
    
    private let workersService = WorkersService()
    private let tableView = UITableView()
    private let employeeHeader = EmployeeHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
        NetworkMonitor.shared.startMonitoring()
        loadData()
        employeesAvatars = avatarsData()
        setUpStyle()
        setUpLayout()
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
            if NetworkMonitor.shared.isConnected {
                print("Connected")
            } else {
                print("Not connected")
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    
    private func showAlert() {

        let alert = UIAlertController(title: "No Internet", message: "This app requires wifi/internet connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpStyle() {
        
        tableView.backgroundColor = UIColor(named: "backgroundColor")
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
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
                self?.employeeHeader.companyNameLabel.text = workersList.company.name
                self?.employees = workersList.company.employees.sorted { employeelhs, employeerhs in
                    
                    employeelhs.name < employeerhs.name
                }
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: Extensions
extension ViewController {
    func avatarsData() -> [Avatar] {
        let avatar1 = Avatar(image: Images.avatar1)
        let avatar2 = Avatar(image: Images.avatar2)
        let avatar3 = Avatar(image: Images.avatar3)
        let avatar4 = Avatar(image: Images.avatar4)
        let avatar5 = Avatar(image: Images.avatar5)
        let avatar6 = Avatar(image: Images.avatar6)
        let avatar7 = Avatar(image: Images.avatar7)
        let avatar8 = Avatar(image: Images.avatar8)
        
        return [avatar1, avatar2, avatar3, avatar4, avatar5, avatar6, avatar7, avatar8]
    }
}

extension ViewController: UITableViewDataSource {
    
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

