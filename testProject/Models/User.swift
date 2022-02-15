//
//  User.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}
