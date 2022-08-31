//
//  Device.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

class Device: NSObject, Codable {
	// MARK: - Properties
    var id: Int
    let deviceName: String
    let productType: ProductType

	// MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case id
        case deviceName
        case productType
    }
    enum ProductType: String, Codable {
        case heater = "Heater"
        case light = "Light"
        case rollerShutter = "RollerShutter"
    }

	// MARK: - Methods
    func userDefaultsKeys() -> [String] {
        return []
    }
}

