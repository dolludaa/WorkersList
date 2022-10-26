import Foundation
import UIKit

class EmployeeCell: UITableViewCell {
    
//    статическоие в самом типе, а не к объекту!!!!!! к проинициалирированным объектам относиться не сможет

    static let reuseIdentifier = "EmployeeCell"
    
    private let headerLabel1 = UILabel()
    private let headerLabel2 = UILabel()
    private let headerLabel3 = UILabel()

    private var employee: Employee?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    private func setupLayout() {
        headerLabel1.translatesAutoresizingMaskIntoConstraints = false
        headerLabel2.translatesAutoresizingMaskIntoConstraints = false
        headerLabel3.translatesAutoresizingMaskIntoConstraints = false


        contentView.addSubview(headerLabel1)
        contentView.addSubview(headerLabel2)
        contentView.addSubview(headerLabel3)
        
        headerLabel1.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 15).isActive = true
        headerLabel1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        headerLabel2.leftAnchor.constraint(equalTo: headerLabel1.leftAnchor,constant: 15).isActive = true
        headerLabel2.topAnchor.constraint(equalTo: headerLabel1.topAnchor, constant: 20).isActive = true
        headerLabel3.topAnchor.constraint(equalTo: headerLabel2.topAnchor, constant: 20).isActive = true
        headerLabel3.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 15).isActive = true
        
    }
    
    func configure(employee: Employee) {
        
        var emptyString = ""
        
        for i in employee.skills.indices {
            emptyString.append(employee.skills[i])
            if i != employee.skills.indices.last {
                emptyString.append(" , ")
            }
        }
        
        self.employee = employee
        headerLabel1.text = "name:  \(employee.name)"
        headerLabel2.text = employee.phone
        headerLabel3.text = emptyString
        
        headerLabel1.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel2.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel3.font = UIFont.boldSystemFont(ofSize: 18)
    }
}



