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
    init(id: Int, deviceName: String, productType: ProductType, mode:Mode, temperature:Int) {
        self.temperature = temperature
        self.mode = mode
        super.init(id: id, deviceName: deviceName, productType: productType)
    }
    
    
    enum Mode: String,Codable {
        case on = "ON"
        case off = "OFF"
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
