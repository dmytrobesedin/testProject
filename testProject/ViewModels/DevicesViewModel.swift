//
//  DevicesViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//


import Foundation
class DevicesViewModel: NSObject {
    private var apiService: APIService?
    public var userDefaultManager: UserDefaultsManager?
    private(set) var deviceData: ModulotestAPIResponse? {
        didSet {
            self.bindDevicesViewModelToController()
        }
    }
    
    public var bindDevicesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.userDefaultManager = UserDefaultsManager()
        self.callFuncToGetDecodeData()
    }
    
    
    private  func callFuncToGetDecodeData()  {
        DispatchQueue.global().async { [weak self] in
            self?.apiService?.apiToGetDeviceData { apiResponseData in
                
                apiResponseData.devices.forEach { device in
                    
                    device.userDefaultsKeys().forEach { key in
                        
                        if UserDefaults.standard.isKeyPresentInUserDefaults(key: key) {
                            let arrayKey = key.components(separatedBy: "|")
                            
                            if device.productType == .heater {
                                guard  let heaterDevice  = device as? Heater else{return}
                                self?.userDefaultManager?.setHeaterDeviceUserDefaults(key: key, arrayKey: arrayKey, heaterDevice: heaterDevice)
                                
                            }
                            
                            else if device.productType == .light {
                                guard  let lightDevice  = device as? Light else{return}
                                self?.userDefaultManager?.setLightDeviceUserDefaults(key: key, arrayKey: arrayKey, lightDevice: lightDevice)
                                
                            }
                            else if device.productType == .rollerShutter {
                                guard  let rollerShutterDevice  = device as? RollerShutter else{return}
                                self?.userDefaultManager?.setRollerShutterDeviceUserDefaults(key: key, arrayKey: arrayKey, rollerShutterDevice: rollerShutterDevice)
                                
                            }
                        }
                    }
                    
                }
                self?.deviceData = apiResponseData
            }
        }
    }
}
