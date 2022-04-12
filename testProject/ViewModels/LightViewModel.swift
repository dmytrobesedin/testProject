//
//  File.swift
//  testProject
//
//  Created by Дмитрий Беседин on 18.02.2022.

import UIKit
import Foundation

class LightViewModel {
    private var lightDataModel: Light
    private var lightVC:UIViewController?
    private var userDefaultsManager = UserDefaultsManager()
    
    required init(device: Light) {
        self.lightDataModel = device
        self.lightVC = LightDetailView(lightViewModel: self)
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
    
    public func setUpLightIntensity(value: Float) {
        let key = "\(self.id)|\(Light.CodingKeys.intensity.rawValue)"
        userDefaultsManager.setUpSliderValue(key, value)
    }
    
    public func setUpLightMode(value: Bool) {
        let key  = "\(self.id)|\(Light.CodingKeys.mode.rawValue)"
        userDefaultsManager.setUpSwitchValue(key, value)
    }
}

extension LightViewModel: DeviceViewModelProtocol{
    func configureDeviceVC() -> UIViewController {
        guard let vc = lightVC else {
            let vc = LightDetailView(lightViewModel: self)
            self.lightVC = vc
            return vc
        }
        return vc
    }
}



