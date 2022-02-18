//
//  File.swift
//  testProject
//
//  Created by Дмитрий Беседин on 18.02.2022.
//

import Foundation
class LightViewModel {
     var lightDataModel: Light
    init(lightDataModel: Light) {
        self.lightDataModel = lightDataModel
    }
    
   public var intensity:String{
        return "intensity - \(lightDataModel.intensity)"
    }
    
    public var mode:String{
        return "mode - \(lightDataModel.mode.rawValue)"
     }
    
    public var deviceName:String{
        return "deviceName - \(lightDataModel.deviceName)"
     }
    public var productType:String{
        return "productType - \(lightDataModel.productType.rawValue)"
     }
    
    var bindDevicesViewModelToController : (() -> ()) = {}
    
}
