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
    var mode: Mode
    
    private enum CodingKeys: String, CodingKey {
          case intensity
          case mode
      }
    
    

    
    required init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.intensity = try container.decode(Int.self, forKey: .intensity)
        self.mode = try  container.decode(Mode.self, forKey: .mode)
        try super.init(from: decoder)
    }
    


    
    enum Mode: String,Decodable {
        case on = "ON"
        case off = "OFF"
    }
    
}
