import Foundation
import UIKit

class EmployeeCell: UITableViewCell {
    
    static let reuseIdentifier = "EmployeeCell"
    
    private let nameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let skillsLabel = UILabel()
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
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneNumberLabel)
        containerView.addSubview(skillsLabel)
        containerView.addSubview(avatarView)
        contentView.addSubview(containerView)
        
        nameLabel.leftAnchor.constraint(equalTo: avatarView.rightAnchor,constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        
        phoneNumberLabel.leftAnchor.constraint(equalTo: avatarView.rightAnchor,constant: 10).isActive = true
        phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        
        skillsLabel.leftAnchor.constraint(equalTo: avatarView.rightAnchor,constant: 10).isActive = true
        skillsLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10).isActive = true
        skillsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        
        avatarView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        avatarView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        avatarView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        let bottomConstraint = containerView.bottomAnchor.constraint(equalTo: skillsLabel.bottomAnchor, constant: 10)
        bottomConstraint.isActive = true
        bottomConstraint.priority = .defaultLow
    }
    
    private func setupStyle() {
        
        backgroundColor = UIColor(named: "backgroundColor")
        selectionStyle = .none
        
        skillsLabel.numberOfLines = 0
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 30
    }
    
    private func convertFromToString(skills: [String]) -> String {
        
        var skillsString = ""
        
        for i in skills.indices {
            skillsString.append(skills[i])
            if i != skills.indices.last {
                skillsString.append(" , ")
            }
        }
        
        return skillsString
    }
    
    @available(iOS 15, *)
    private func getAttributedName(key: String, value: String) -> AttributedString {
        
        var valueAttributedString = AttributedString(value)
        
        valueAttributedString.font = .systemFont(ofSize: 15, weight: .light)
        
        var keyAttributedString = AttributedString(key)

        keyAttributedString.foregroundColor = .systemBrown
        keyAttributedString.font = .boldSystemFont(ofSize: 17)
        keyAttributedString.append(valueAttributedString)
        
        return keyAttributedString
    }
    
    private func configureLabelsText(employee: Employee) {
        
        let convertedSkillsString = convertFromToString(skills: employee.skills)
        if #available(iOS 15, *) {
            nameLabel.attributedText = getAttributedName(key: "name: ", value: employee.name).nsAttributedString
            phoneNumberLabel.attributedText = getAttributedName(key: "phone number: ", value: employee.phoneNumber).nsAttributedString
            skillsLabel.attributedText = getAttributedName(key: "skills: ", value:
                                                            convertedSkillsString).nsAttributedString
        } else {
            nameLabel.text = "name: \(employee.name)"
            phoneNumberLabel.text = "phone number: \(employee.phoneNumber)"
            skillsLabel.text = "skills: \(convertedSkillsString)"
        }
    }
    
    func configure(employee: Employee, avatar: Avatar?) {
        
        configureLabelsText(employee: employee)
        
        avatarView.image = avatar?.image
    }
}


