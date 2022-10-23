//
//  Heater.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

class Heater: Device {
	// MARK: - Properties
    var temperature: Int
    var mode: Mode

	// MARK: - CodingKeys
    public enum CodingKeys: String, CodingKey {
        case temperature
        case mode
    }

	// MARK: - Init
    required init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.temperature = try container.decode(Int.self, forKey: .temperature)
        self.mode = try container.decode(Mode.self, forKey: .mode)
        try super.init(from: decoder)
    }

	//  MARK: - Override methods
    override func userDefaultsKeys() -> [String] {
        return [String(super.id) + "|" + CodingKeys.temperature.rawValue,
                String(super.id) + "|" + CodingKeys.mode.rawValue]
    }
}
