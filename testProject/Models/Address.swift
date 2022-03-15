//
//  Address.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

// MARK: - Address
struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
