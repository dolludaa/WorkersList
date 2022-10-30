import Foundation
import UIKit

class EmployeeHeaderView: UIView {
    
    private let symbolView = UIImageView()
    private let companyNameLabel = UILabel()
    
    func showConnection() {
        
        symbolView.isHidden = true
    }
    
    func showDisconnection() {
        
        symbolView.isHidden = false
    }
    
    func setCompanyName(name: String) {
        
        companyNameLabel.text = name
    }
    
    private func setupLayout() {
        
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(symbolView)
        addSubview(companyNameLabel)
        
        companyNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        companyNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        companyNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        companyNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        symbolView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        symbolView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        symbolView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        symbolView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupStyle() {
        
        companyNameLabel.font = UIFont.boldSystemFont(ofSize: 45)
        companyNameLabel.adjustsFontForContentSizeCategory = true
        
        symbolView.image = UIImage(systemName: "wifi.slash")
        symbolView.isHidden = true
        symbolView.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
