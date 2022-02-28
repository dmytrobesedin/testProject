//
//  RollerShutter.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation



// MARK: - RollerShutter
class RollerShutter: Device {
    let position: Int
  
    private enum CodingKeys: String, CodingKey {
        case position
        
    }

    required init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.position = try container.decode(Int.self, forKey: .position)
        try super.init(from: decoder)
    }
    // for encode the  value
    override func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try? values.encodeIfPresent(position, forKey: .position)
        }
    
    
    override func userDefaultsKeys() -> [String] {
        return [String(super.id) + "|" + CodingKeys.position.rawValue]
    }
}
