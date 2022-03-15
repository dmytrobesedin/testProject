//
//  RollerShutterViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import Foundation

class RollerShutterViewModel {
    private var rollerShutterDataModel: RollerShutter
    public var userDefaultsManager = UserDefaultsManager()
    init(rollerShutterDataModel: RollerShutter) {
        self.rollerShutterDataModel = rollerShutterDataModel
    }
    public var id: Int {
        return rollerShutterDataModel.id
    }
    public var position: Int {
        return rollerShutterDataModel.position
    }
    
    public var deviceName: String {
        return rollerShutterDataModel.deviceName
    }
    public var productType: String {
        return rollerShutterDataModel.productType.rawValue
    }
    
}
