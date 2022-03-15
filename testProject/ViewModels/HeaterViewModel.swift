//
//  HeaterViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import Foundation
class HeaterViewModel {
    private var heaterDataModel: Heater
    public var userDefaultsManager = UserDefaultsManager()
    init(heaterDataModel: Heater) {
        self.heaterDataModel = heaterDataModel
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
    
}
