//
//  Data.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation


// MARK: - ModulotestAPIResponse
struct ModulotestAPIResponse:  Codable {
    var devices: [Device]
  //  var encodeDeivces:[Device]
    

   // var user: User
    
    enum ModulotestAPIResponseKey:CodingKey {
        case devices
       // case user
    }
    enum DeviceTypeKey: String, CodingKey  {

        case productType
    }
    enum DeviceTypes:String, Codable {
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

//    func encode(to encoder: Encoder) throws {
//        var values = encoder.container(keyedBy: ModulotestAPIResponseKey.self)
//
//
//        var deviceTypeForArray =  values.nestedUnkeyedContainer(forKey: ModulotestAPIResponseKey.devices)
//
//        var nestedContainer  =  deviceTypeForArray.nestedContainer(keyedBy: DeviceTypeKey.self)
//        let productType = nestedContainer.encode(DeviceTypes.type, forKey: .productType)
//       var device =  nestedContainer.encode(DeviceTypes.self, forKey: DeviceTypeKey.productType)
//
//        try nestedContainer.encode(<#T##value: Bool##Bool#>, forKey: <#T##KeyedEncodingContainer<DeviceTypeKey>.Key#>)
//
//
//        var devicesArray = d
//          try? values.encodeIfPresent(, forKey: .id)
//          try? values.encodeIfPresent(, forKey: .name)
//          try? values.encodeIfPresent(createdDate, forKey: .createdDate)
//        }

}
