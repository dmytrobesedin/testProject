//
//  Address.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

struct Address: Codable {
	// MARK: - Properties
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
