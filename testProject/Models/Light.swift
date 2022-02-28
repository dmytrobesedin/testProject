//
//  Light.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

// MARK: - Light
class Light: Device {
    var intensity: Int
    var mode: LightMode
    
    private enum CodingKeys: String, CodingKey {
          case intensity
          case mode
      }

    init(id: Int, deviceName: String, productType: ProductType, intensity:Int, mode:LightMode) {
        self.intensity = intensity
        self.mode = mode
        super.init(id: id, deviceName: deviceName, productType: productType)
    }
    
    required init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.intensity = try container.decode(Int.self, forKey: .intensity)
        self.mode = try  container.decode(LightMode.self, forKey: .mode)
        try super.init(from: decoder)
    }
    

    // for encode the  value
    override func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try? values.encodeIfPresent(intensity, forKey: .intensity)
        try? values.encodeIfPresent(mode, forKey: .mode)
        try super.encode(to: encoder)
        }

    
    enum LightMode: String,Codable {
        case on = "ON"
        case off = "OFF"
    }
    
    override func userDefaultsKeys() -> [String] {
        return [String(super.id) + "|" + CodingKeys.intensity.rawValue,
                String(super.id) + "|" + CodingKeys.mode.rawValue]
    }
    
}
