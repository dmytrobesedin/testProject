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
    
    var devicesViewModelDelegate: DevicesViewModelDelegate?
    var connectDevicesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.userDefaultManager = UserDefaultsManager()
        
//        deviceData?.deviceDidChangeAction = {[weak self] in
//            guard let self = self  else {return}
//            self.getDecodeData()
//        }
//
        deviceData?.delegate = self
        
        self.getDecodeData()
    }
    
    private func getDecodeData()  {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.apiService?.apiToGetDeviceData { apiResponseData in
//                apiResponseData.devices.forEach { device in
//                    device.userDefaultsKeys().forEach { key in
//                        self.userDefaultManager?.checkKeyInUserDefaults(key, device)
//                    }
//                }
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
    
    func configureVC(_ device: Device) {
        guard let newViewModel = DevicesFactory.devicesFactory.create(device) else{return}
        let vc = newViewModel.configureDeviceVC()
        self.devicesViewModelDelegate?.didFinishConfiguringVC(vc)
    }    
}

extension DevicesViewModel:ModulotestAPIResponseDelegate{
    func deviceDidChangeAction() {
        
            getDecodeData()
    }
}
