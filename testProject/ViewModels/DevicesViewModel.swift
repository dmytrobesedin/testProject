//
//  DevicesViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//


import Foundation
class DevicesViewModel: NSObject {
    var apiService: APIService!
   // var selectedDevice: Device
    private(set) var deviceData: ModulotestAPIResponse? {
        didSet {
            self.bindDevicesViewModelToController()
        }
    }
    
    var bindDevicesViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.callFuncToGetDecodeData()
    }
    
    func callFuncToGetDecodeData()  {
        DispatchQueue.global().async {
            self.apiService.apiToGetDeviceData { apiResponse in
                self.deviceData = apiResponse
            }
        }
    }
    
    func moveToDetails() {
        
    }
}
