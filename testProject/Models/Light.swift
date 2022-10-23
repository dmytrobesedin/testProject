//
//  Light.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

class Light: Device {
	// MARK: - Properties
    var intensity: Int
    var mode: Mode

	// MARK: - CodingKeys
    public enum CodingKeys: String, CodingKey {
        case intensity
        case mode
    }

	// MARK: - Init
    required init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.intensity = try container.decode(Int.self, forKey: .intensity)
        self.mode = try container.decode(Mode.self, forKey: .mode)
        try super.init(from: decoder)
    }

	// MARK: - Override methods
    override func userDefaultsKeys() -> [String] {
        return [String(super.id) + "|" + CodingKeys.intensity.rawValue,
                String(super.id) + "|" + CodingKeys.mode.rawValue]
    }
}
