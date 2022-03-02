//
//  DevicesViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//


import Foundation
class DevicesViewModel: NSObject {
    var apiService: APIService!
    var userDefaultManager: UserDefaultsManager!
    private(set) var deviceData: ModulotestAPIResponse? {
        didSet {
            self.bindDevicesViewModelToController()
        }
    }
    
    var bindDevicesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.userDefaultManager = UserDefaultsManager()
        self.callFuncToGetDecodeData()
    }
    

    
 
    
    
    func callFuncToGetDecodeData()  {
        DispatchQueue.global().async {
            self.apiService.apiToGetDeviceData { apiResponseData in
                
                apiResponseData.devices.forEach { device in
                    
                    device.userDefaultsKeys().forEach { key in
                        
                      //  print(key)
                        
                        if UserDefaults.standard.isKeyPresentInUserDefaults(key: key) {
                            let arrayKey = key.components(separatedBy: "|")
             
                            if device.productType == .heater {
                                guard  let heaterDevice  = device as? Heater else{return}
                                self.userDefaultManager.setHeaterDeviceUserDefaults(key, arrayKey, heaterDevice)
                                
                            }
                            
                            else if device.productType == .light {
                                guard  let lightDevice  = device as? Light else{return}
                                self.userDefaultManager.setLightDeviceUserDefaults(key, arrayKey, lightDevice)
                               
                            }
                            else if device.productType == .rollerShutter {
                                guard  let rollerShutterDevice  = device as? RollerShutter else{return}
                                self.userDefaultManager.setRollerShutterDeviceUserDefaults(key, arrayKey, rollerShutterDevice)
                                
                            }
                        }
                    }
                    
                }
                self.deviceData = apiResponseData
            }
        }
    }
}
