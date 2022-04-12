//
//  RollerShutterViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//
import UIKit
import Foundation

class RollerShutterViewModel {
    private var rollerShutterDataModel: RollerShutter
    private var rollerShutterVC: UIViewController?
    private var userDefaultsManager = UserDefaultsManager()
    
    required init(device: RollerShutter) {
        self.rollerShutterDataModel = device
        self.rollerShutterVC = RollerShutterDetailView(rollerShutterViewModel: self)
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
    
    public func setUpRollerShutterPosition(value: Float) {
        let key = "\(self.id)|\(RollerShutter.CodingKeys.position.rawValue)"
        userDefaultsManager.setUpSliderValue(key, value)
    }
}

extension RollerShutterViewModel:DeviceViewModelProtocol{
    func configureDeviceVC() -> UIViewController {
        guard let vc = rollerShutterVC else {
            let vc = RollerShutterDetailView(rollerShutterViewModel: self)
            self.rollerShutterVC = vc
            return vc
        }
        return vc
    }
}

