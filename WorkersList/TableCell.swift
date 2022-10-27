import Foundation
import UIKit

class EmployeeCell: UITableViewCell {

    static let reuseIdentifier = "EmployeeCell"
    
    private let headerLabel1 = UILabel()
    private let headerLabel2 = UILabel()
    private let headerLabel3 = UILabel()
    private let avatarView = UIImageView()
    private let containerView = UIView()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupStyle()
    }
    private func setupLayout() {
        headerLabel1.translatesAutoresizingMaskIntoConstraints = false
        headerLabel2.translatesAutoresizingMaskIntoConstraints = false
        headerLabel3.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(headerLabel1)
        containerView.addSubview(headerLabel2)
        containerView.addSubview(headerLabel3)
        containerView.addSubview(avatarView)
        contentView.addSubview(containerView)
        
        headerLabel1.leftAnchor.constraint(equalTo: avatarView.rightAnchor,constant: 10).isActive = true
        headerLabel1.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        
        headerLabel2.leftAnchor.constraint(equalTo: avatarView.rightAnchor,constant: 10).isActive = true
        headerLabel2.topAnchor.constraint(equalTo: headerLabel1.bottomAnchor, constant: 10).isActive = true
        
        headerLabel3.leftAnchor.constraint(equalTo: avatarView.rightAnchor,constant: 10).isActive = true
        headerLabel3.topAnchor.constraint(equalTo: headerLabel2.bottomAnchor, constant: 10).isActive = true
        headerLabel3.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        
        
        avatarView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        avatarView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: headerLabel3.bottomAnchor, constant: 10)
        bottomConstraint.isActive = true
        bottomConstraint.priority = .defaultLow
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true

    }
    
    private func setupStyle() {
        
        backgroundColor = .clear
        avatarView.layer.cornerRadius = 30
        headerLabel3.numberOfLines = 0
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 30
    }
    
    func configure(employee: Employee, avatar: Avatar?) {
        
        var emptyString = ""
        
        for i in employee.skills.indices {
            emptyString.append(employee.skills[i])
            if i != employee.skills.indices.last {
                emptyString.append(" , ")
            }
        }
        
        avatarView.image = avatar?.image
    
        headerLabel1.text = "name:  \(employee.name)"
        headerLabel2.text = "phone number:  \(employee.phone)"
        headerLabel3.text = "skills:  \(emptyString)"
        
        headerLabel1.font = UIFont.systemFont(ofSize: 15)
        headerLabel2.font = UIFont.systemFont(ofSize: 15)
        headerLabel3.font = UIFont.systemFont(ofSize: 15)
        
    }
}


