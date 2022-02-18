//
//  Device.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation



// MARK: - Device
class Device: Decodable {
    let id: Int
    let deviceName: String
    let productType: ProductType
    
  
    private enum CodingKeys: String, CodingKey{
        case id
        case deviceName
        case productType
    }
    enum ProductType: String, Decodable {
        case heater = "Heater"
        case light = "Light"
        case rollerShutter = "RollerShutter"
    }
    
    
    

}

