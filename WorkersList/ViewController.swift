//
//  ViewController.swift
//  WorkersList
//
//  Created by Людмила Долонтаева on 24.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var employees: [Employee] = [] 
    private let workersService = WorkersService()
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //         не безопасный, возвращает просто тип не знаем что это за объект и нужно писать as
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EmployeeCell.reuseIdentifier, for: indexPath
        ) as! EmployeeCell
        
        let employee = employees[indexPath.row]
        cell.configure(employee: employee)
        return cell
    }
    
    private var tableView = UITableView()
    
    private func setUpStyle() {
        tableView.backgroundColor = .lightGray
        //        регистрируем TABLE CELL
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
    }
    
    private func setUpLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    private func loadData() {
        
        workersService.fetchResultsFromApi { [weak self] result in
            switch result {
            case .success(let workersList):
                self?.employees = workersList.company.employees.sorted { employeelhs, employeerhs in
                    
                    employeelhs.name < employeerhs.name
                }
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setUpStyle()
        setUpLayout()
    }
}




