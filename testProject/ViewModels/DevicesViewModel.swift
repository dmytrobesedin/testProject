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
                            let arrayKey = key.components(separatedBy: "|")
                            
                            
                            
                            if device.productType == .heater {
                            if arrayKey[1] == Heater.CodingKeys.temperature.rawValue {
                                guard  let heaterDevice  = device as? Heater else{return}
                                
                                guard let newValueTemp = UserDefaults.standard.object(forKey: key) as? Int else{return}
                                heaterDevice.temperature = newValueTemp
                                
                            }
                            else if arrayKey[1] == Heater.CodingKeys.mode.rawValue {
                                guard  let heaterDevice  = device as? Heater else{return}
                                
                                guard let newValueMode = UserDefaults.standard.object(forKey: key) as? Bool else{return}
                                if newValueMode{
                                    heaterDevice.mode = .on
                                }
                                else if newValueMode == false{
                                    heaterDevice.mode = .off
                                }
                            }
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
