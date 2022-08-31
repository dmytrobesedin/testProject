//
//  RollerShutter.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

class RollerShutter: Device {
	// MARK: - Properties
    var position: Int

	// MARK: - CodingKeys
    public enum CodingKeys: String, CodingKey {
        case position
    }

	// MARK: - Init
    required init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.position = try container.decode(Int.self, forKey: .position)
        try super.init(from: decoder)
    }

	// MARK: - Override methods
    override func userDefaultsKeys() -> [String] {
        return [String(super.id) + "|" + CodingKeys.position.rawValue]
    }
}
