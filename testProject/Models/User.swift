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
}
