//
//  Heater.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation


// MARK: - Heater
class Heater: Device {
    var temperature:Int
    var mode: Mode
    
    
  
    private enum CodingKeys: String, CodingKey {
        case temperature
        case mode
        
    }
    
    
    enum Mode: String,Codable {
        case on = "ON"
        case off = "OFF"
    }
    
    required init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.temperature = try container.decode(Int.self, forKey: .temperature)
        self.mode = try container.decode(Mode.self, forKey: .mode)
        try super.init(from: decoder)
    }
    
    
}
