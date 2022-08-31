//
//  User.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

struct User: Codable {
	// MARK: - Properties
    let firstName: String
    let lastName: String
    let address: Address
    let birthDate: Int

	// MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case address
        case birthDate
    }
}
