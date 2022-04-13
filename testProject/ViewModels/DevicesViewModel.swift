//
//  DevicesViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit
import Foundation

class DevicesViewModel: NSObject {
    private var apiService: APIService?
    private(set) var userDefaultManager: UserDefaultsManager?
    private(set) var deviceData: ModulotestAPIResponse? {
        didSet {
            self.connectDevicesViewModelToController()
        }
    }
    weak var devicesViewModelDelegate: DevicesViewModelDelegate?
    var connectDevicesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.userDefaultManager = UserDefaultsManager()
        notifyModulotestAPIResponse()
        self.getDecodeData()
    }
    
    private func getDecodeData()  {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiService?.apiToGetDeviceData { apiResponseData in
                self.deviceData = apiResponseData
            }
        }
    }
    
    func updateDataInUserDefaults() {
        self.deviceData?.devices.forEach({ device in
            device.userDefaultsKeys().forEach { key in
                self.userDefaultManager?.checkKeyInUserDefaults(key, device)
            }
        })
        self.devicesViewModelDelegate?.didFinishUpdatingData()
    }
    
    private func notifyModulotestAPIResponse() {
        deviceData?.devicesDidChangeAction = {[weak self] in
            guard let self = self  else {return}
            self.getDecodeData()
        }
    }
    
    func configureVC(_ device: Device) {
        guard let newViewModel = DevicesFactory.devicesFactory.create(device) else{return}
        let vc = newViewModel.configureDeviceVC()
        self.devicesViewModelDelegate?.didFinishConfiguringVC(vc)
    }    
}
