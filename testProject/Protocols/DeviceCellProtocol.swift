//
//  DeviceCellProtocol.swift
//  testProject
//
//  Created by Дмитрий Беседин on 28.03.2022.
//

import Foundation

protocol DeviceCellProtocol {
    associatedtype DeviceViewModelType
    func configureCell(deviceViewModel: DeviceViewModelType)  
}
