import Foundation

struct WorkersList: Decodable {
    let company: Company
}

struct Company: Decodable {
    let name: String
    let employees: [Employee]
}

struct Employee: Decodable {
    let name: String
    let phone: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, skills
        case phone = "phone_number"
        
    }
}


    

