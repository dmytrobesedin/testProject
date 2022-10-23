//
//  DevicesFactory.swift
//  testProject
//
//  Created by Дмитрий Беседин on 22.03.2022.
//

import Foundation

final class DevicesFactory {
	// MARK: - Constants
    static let devicesFactory = DevicesFactory()

	// MARK: - Methods
    func create(_ device: Device) -> DeviceViewModelProtocol? {
        switch device.productType {
        case .light:
            guard let lightDevice = device as? Light else { return nil }
            return  LightViewModel(device: lightDevice)
            
        case .heater:
            guard let heaterDevice = device as? Heater else { return nil }
            return HeaterViewModel(device: heaterDevice)
            
        case .rollerShutter:
            guard let rollerShutterDevice = device as? RollerShutter else { return nil }
            return  RollerShutterViewModel(device: rollerShutterDevice)
        }
    }
}
