//
//  Device.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation



// MARK: - Device
class Device: NSObject, Codable {
    let id: Int
    let deviceName: String
    let productType: ProductType
    
    init(id:Int, deviceName:String, productType:ProductType) {
        self.id = id
        self.deviceName = deviceName
        self.productType = productType
    }
    
    
    
    private enum CodingKeys: String, CodingKey{
        case id
        case deviceName
        case productType
    }
    enum ProductType: String, Codable {
        case heater = "Heater"
        case light = "Light"
        case rollerShutter = "RollerShutter"
    }
    
    func saveToUD() {
        
    }
    
    func userDefaultsKeys() -> [String] {
        return []
    }
    

}

