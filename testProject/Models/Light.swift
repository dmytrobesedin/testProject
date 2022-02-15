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
    
    
    init(id: Int, deviceName: String, productType: ProductType,intensity: Int, mode:Mode) {
        self.intensity = intensity
        self.mode = mode 
        super.init(id: id, deviceName: deviceName, productType: productType)
       
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    enum Mode: String,Codable {
        case on = "ON"
        case off = "OFF"
    }
    
}
