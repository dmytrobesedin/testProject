//
//  Data.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation
// MARK: - ModulotestAPIResponse
class ModulotestAPIResponse: Decodable {
    var devices: [Device] {
        didSet{
            if let closure = devicesDidChangeAction{
                closure()
            }
        }
    }
    var devicesDidChangeAction:(()->())?
    
    enum ModulotestAPIResponseKey:CodingKey {
        case devices
    }
    
    enum DeviceTypeKey: String, CodingKey  {
        case productType
    }
    
    enum DeviceTypes:String, Codable {
        case heater = "Heater"
        case light = "Light"
        case rollerShutter = "RollerShutter"
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: ModulotestAPIResponseKey.self)
        var devicesArrayForType = try container.nestedUnkeyedContainer(forKey: ModulotestAPIResponseKey.devices)
        var devices = [Device]()
        var devicesArray = devicesArrayForType
        
        while (!devicesArrayForType.isAtEnd ) {
            let device = try devicesArrayForType.nestedContainer(keyedBy: DeviceTypeKey.self)
            let productType = try device.decode(DeviceTypes.self, forKey: DeviceTypeKey.productType)
            switch productType {
            case .light:
                devices.append(try devicesArray.decode(Light.self))
            case .heater:
                devices.append(try devicesArray.decode(Heater.self))
            case .rollerShutter:
                devices.append(try devicesArray.decode(RollerShutter.self))
            }
        }
        self.devices = devices
    }
}
