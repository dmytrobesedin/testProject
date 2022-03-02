//
//  File.swift
//  testProject
//
//  Created by Дмитрий Беседин on 18.02.2022.

import UIKit
import Foundation

class LightViewModel {
    var lightDataModel: Light
    var userDefaultsManager = UserDefaultsManager()
    init(lightDataModel: Light) {
        self.lightDataModel = lightDataModel
    }
    
    public var intensity: Int {
        return lightDataModel.intensity
    }
    
    public var mode: Light.LightMode {
        return lightDataModel.mode
    }
    
    public var deviceName: String {
        return lightDataModel.deviceName
    }
    public var productType: String {
        return lightDataModel.productType.rawValue
    }
    public var id: Int {
        return lightDataModel.id
    }
    
}


