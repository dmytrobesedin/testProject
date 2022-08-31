//
//  DevicesViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit
import Foundation

 final class DevicesViewModel: NSObject {
	// MARK: - Properties
	weak var devicesViewModelDelegate: DevicesViewModelDelegate?

	// MARK: - Private properties
    private var apiService: APIService?
    private(set) var userDefaultManager: UserDefaultsManager?
    private(set) var deviceData: ModulotestAPIResponse? {
        didSet {
            self.connectDevicesViewModelToController()
        }
    }

	// MARK: Callbacks
    var connectDevicesViewModelToController : (() -> ()) = {}

	// MARK: - Init
    override init() {
        super.init()
        self.apiService = APIService()
        self.userDefaultManager = UserDefaultsManager()
        notifyModulotestAPIResponse()
        self.getDecodeData()
    }
    
	// MARK: - Methods
    func updateDataInUserDefaults() {    
        deviceData?.devices.forEach({ device in
            device.userDefaultsKeys().forEach { key in
                self.userDefaultManager?.checkKeyInUserDefaults(key, device)
            }
        })
        self.devicesViewModelDelegate?.didFinishUpdatingData()
    }

	func configureVC(_ device: Device) {
		guard let newViewModel = DevicesFactory.devicesFactory.create(device) else{return}
		let vc = newViewModel.configureDeviceVC()
		self.devicesViewModelDelegate?.didFinishConfiguringVC(vc)
	}

	// MARK: - Private methods
	private func getDecodeData()  {
		DispatchQueue.global().async { [weak self] in
			guard let self = self else { return }
			self.apiService?.apiToGetDeviceData { apiResponseData in
				apiResponseData.devices.forEach { device in
					device.userDefaultsKeys().forEach { key in
						self.userDefaultManager?.checkKeyInUserDefaults(key, device)
					}
				}
				self.deviceData = apiResponseData
			}
		}
	}

    private func notifyModulotestAPIResponse() {
        deviceData?.devicesDidChangeAction = {[weak self] in
            guard let self = self else {return}
            self.getDecodeData()
        }
    }
}
