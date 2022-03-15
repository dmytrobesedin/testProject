//
//  UserDefaultsManager.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import Foundation

class UserDefaultsManager: UserDefaults {
    
    public let defaults = UserDefaults.standard
    
    
    
    public   func setHeaterDeviceUserDefaults( key:String, arrayKey: [String], heaterDevice:Heater) {
        if arrayKey[1] == Heater.CodingKeys.temperature.rawValue {
            guard let newValueTemp = defaults.object(forKey: key) as? Int else{return}
            heaterDevice.temperature = newValueTemp
            
        }
        else if arrayKey[1] == Heater.CodingKeys.mode.rawValue {
            guard let newValueMode = defaults.object(forKey: key) as? Bool else{return}
            if newValueMode{
                heaterDevice.mode = .on
            }
            else if newValueMode == false{
                heaterDevice.mode = .off
            }
        }
    }
    public func setLightDeviceUserDefaults( key: String,  arrayKey: [String],   lightDevice: Light) {
        if arrayKey[1] == Light.CodingKeys.intensity.rawValue {
            
            guard let newValueInten = defaults.object(forKey: key) as? Int else{return}
            lightDevice.intensity = newValueInten
            
        }
        else if arrayKey[1] == Light.CodingKeys.mode.rawValue {
            
            guard let newValueMode = defaults.object(forKey: key) as? Bool else{return}
            if newValueMode{
                lightDevice.mode = .on
            }
            else if newValueMode == false{
                lightDevice.mode = .off
            }
        }
    }
    public func setRollerShutterDeviceUserDefaults( key: String,  arrayKey: [String],   rollerShutterDevice: RollerShutter) {
        if arrayKey[1] == RollerShutter.CodingKeys.position.rawValue {
            guard let newValuePos = defaults.object(forKey: key) as? Int else{return}
            rollerShutterDevice.position = newValuePos
        }
    }
    
}
