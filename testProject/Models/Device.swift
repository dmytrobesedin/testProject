//
//  Device.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation


protocol DeviceProtocol {
    var id: Int { get }
    var deviceName: String { get }
    var productType: ProductType { get }
    init(id:Int, deviceName: String, productType: ProductType)
}


// MARK: - Device
class Device: Codable {
    let id: Int
    let deviceName: String
    let productType: ProductType
    
 public init(id:Int, deviceName: String, productType: ProductType) {
        self.id = id
        self.deviceName = deviceName
        self.productType = productType
    }
}
enum ProductType: String, Codable {
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}
