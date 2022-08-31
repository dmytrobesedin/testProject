//
//  RollerShutterViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//
import UIKit
import Foundation

 final class RollerShutterViewModel {
	// MARK: - Properties
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

	// MARK: - Private properties
    private var rollerShutterDataModel: RollerShutter
    private var rollerShutterVC: UIViewController?
    private var userDefaultsManager = UserDefaultsManager()

	// MARK: - Init
    required init(device: RollerShutter) {
        self.rollerShutterDataModel = device
        self.rollerShutterVC = RollerShutterDetailView(rollerShutterViewModel: self)
    }

	// MARK: - Methods
    public func setUpRollerShutterPosition(value: Float) {
        let key = "\(self.id)|\(RollerShutter.CodingKeys.position.rawValue)"
        userDefaultsManager.setUpSliderValue(key, value)
    }
}

// MARK: - DeviceViewModelProtocol
extension RollerShutterViewModel: DeviceViewModelProtocol {
    func configureDeviceVC() -> UIViewController {
        guard let vc = rollerShutterVC else {
            let vc = RollerShutterDetailView(rollerShutterViewModel: self)
            self.rollerShutterVC = vc
            return vc
        }
        return vc
    }
}

