//
//  DevicesViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//


import Foundation

protocol DevicesViewModelDelegate {
    func didFinishUpdatingData()
}

class DevicesViewModel: NSObject {
    private var apiService: APIService?
    public var userDefaultManager: UserDefaultsManager?
    private(set) var deviceData: ModulotestAPIResponse? {
        didSet {
            self.connectDevicesViewModelToController()
        }
    }
    var devicesViewModelDelegate: DevicesViewModelDelegate?
    
    public var connectDevicesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.userDefaultManager = UserDefaultsManager()
        self.callFuncToGetDecodeData()
    }
    
    private  func callFuncToGetDecodeData()  {
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
    func callFuncToUpdateData() {
        self.deviceData?.devices.forEach({ device in
            device.userDefaultsKeys().forEach { key in
                self.userDefaultManager?.checkKeyInUserDefaults(key, device)
            }
        })
        self.devicesViewModelDelegate?.didFinishUpdatingData()
    }
}
