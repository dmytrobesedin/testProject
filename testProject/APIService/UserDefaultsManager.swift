//
//  UserDefaultsManager.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import Foundation

class UserDefaultsManager: UserDefaults {
    
    public   func setHeaterDeviceUserDefaults(_ key:String, _ arrayKey: [String],_ heaterDevice:Heater) {
        if arrayKey[1] == Heater.CodingKeys.temperature.rawValue {
            guard let newValueTemp = UserDefaults.standard.object(forKey: key) as? Int else{return}
            heaterDevice.temperature = newValueTemp
            
        }
        else if arrayKey[1] == Heater.CodingKeys.mode.rawValue {
            guard let newValueMode = UserDefaults.standard.object(forKey: key) as? Bool else{return}
            if newValueMode{
                heaterDevice.mode = .on
            }
            else if newValueMode == false{
                heaterDevice.mode = .off
            }
        }
    }
    public func setLightDeviceUserDefaults(_ key: String, _ arrayKey: [String],  _ lightDevice: Light) {
        if arrayKey[1] == Light.CodingKeys.intensity.rawValue {
          
            guard let newValueInten = UserDefaults.standard.object(forKey: key) as? Int else{return}
            lightDevice.intensity = newValueInten
            
        }
        else if arrayKey[1] == Light.CodingKeys.mode.rawValue {
           
            guard let newValueMode = UserDefaults.standard.object(forKey: key) as? Bool else{return}
            if newValueMode{
                lightDevice.mode = .on
            }
            else if newValueMode == false{
                lightDevice.mode = .off
            }
        }
    }
    public func setRollerShutterDeviceUserDefaults(_ key: String, _ arrayKey: [String],  _ rollerShutterDevice: RollerShutter) {
        if arrayKey[1] == RollerShutter.CodingKeys.position.rawValue {
            guard let newValuePos = UserDefaults.standard.object(forKey: key) as? Int else{return}
            rollerShutterDevice.position = newValuePos
        }
    }
    
}
