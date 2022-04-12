//
//  HeaterViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import Foundation
import UIKit

class HeaterViewModel {
    private var heaterDataModel: Heater
    private var heaterVC:UIViewController?
    private var userDefaultsManager = UserDefaultsManager()
    
    required init(device: Heater) {
        self.heaterDataModel = device
        self.heaterVC = HeaterDetailView(heaterViewModel: self)
    }
    
    public var id: Int {
        return heaterDataModel.id
    }
    public var temperature: Int {
        return heaterDataModel.temperature
    }
    public var mode: Heater.Mode {
        return heaterDataModel.mode
    }
    public var deviceName: String {
        return heaterDataModel.deviceName
    }
    public var productType: String {
        return heaterDataModel.productType.rawValue
    }
    
    public func setUpHeaterTemperature(value: Float) {
        let key = "\(self.id)|\(Heater.CodingKeys.temperature.rawValue)"
        userDefaultsManager.setUpSliderValue(key, value)
    }
    public func setUpHeaterMode(value: Bool) {
        let key = "\(self.id)|\(Heater.CodingKeys.mode.rawValue)"
        userDefaultsManager.setUpSwitchValue(key, value)
    }
}

extension HeaterViewModel: DeviceViewModelProtocol{
    func configureDeviceVC() -> UIViewController {
        guard let vc = heaterVC else {
            let vc = HeaterDetailView(heaterViewModel: self)
            self.heaterVC = vc
            return vc
        }
        return vc
    }
}
