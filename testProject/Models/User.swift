//
//  User.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let firstName: String
    let lastName: String
    let address: Address
    let birthDate: Int
    
    
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case address
        case birthDate
        
    }
    //    required init(from decoder: Decoder) throws {
    //        let container  = try decoder.container(keyedBy: CodingKeys.self)
    //        self.firstName = try container.decode(String.self, forKey: .firstName)
    //        self.lastName = try container.decode(String.self, forKey: .lastName)
    //        self.address = try container.decode(Address.self, forKey: .address)
    //        self.birthDate = try container.decode(Int.self, forKey: .birthDate)
    //        try super.init(from: decoder)
    //    }
}
