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
                        
                    print(key)
                        
                        if UserDefaults.standard.isKeyPresentInUserDefaults(key: key) {
                      
                            
                            if device.productType == .heater {
                                
                                
                                guard  let heaterDevice  = device as? Heater else{return}
                                
                                guard let newValue = UserDefaults.standard.object(forKey: key) as? Int else{return}
                                
                                heaterDevice.temperature = newValue
                                
                            }
                        }
//                        else {
//                            guard let heaterDevice  = device as? Heater else{return}
//                            self.userDefaultManager.setValue(heaterDevice.temperature, forKey:  g(heaterDevice.id) + String(Heater.CodingKeys.temperature.rawValue))
//                        }
                    }
                    
                }
                self.deviceData = apiResponseData
            }
        }
    }
}
