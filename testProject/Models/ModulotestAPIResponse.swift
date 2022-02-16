//
//  Data.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation


// MARK: - Data
struct ModulotestAPIResponse: Decodable {
    var devices: [Device]
   // var user: User
    

    enum ModulotestAPIResponseKey:CodingKey {
        case devices
       // case user
    }
    enum DeviceTypeKey: CodingKey {
        case productType
    }
    enum DeviceTypes:String, Decodable {
        case heater = "Heater"
        case light = "Light"
        case rollerShutter = "RollerShutter"
    }
    
    
     init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: ModulotestAPIResponseKey.self)
        var devicesArrayForType = try container.nestedUnkeyedContainer(forKey: ModulotestAPIResponseKey.devices)
        var devices = [Device]()
        
        var devicesArray = devicesArrayForType
        while (!devicesArrayForType.isAtEnd ) {
            let device = try devicesArrayForType.nestedContainer(keyedBy: DeviceTypeKey.self)
            let productType = try device.decode(DeviceTypes.self, forKey: DeviceTypeKey.productType)
            switch productType {
            case .light:
                print("found a light")
                devices.append(try devicesArray.decode(Light.self))
            case .heater:
                print("found a heater")
                devices.append(try devicesArray.decode(Heater.self))
            case .rollerShutter:
                
                
                print("found a rollerShutter")
 
                devices.append(try devicesArray.decode(RollerShutter.self))
           
            }
            
           
            
            
        }
      
       
        self.devices = devices
        
       
    }
}
