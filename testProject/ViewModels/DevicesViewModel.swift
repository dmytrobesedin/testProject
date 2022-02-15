//
//  DevicesViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//


import Foundation
class DevicesViewModel: NSObject {
    var apiService: APIService!
    private(set) var empData: APIResponse? {
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
            
            self.apiService.apiToGetEmployeeData { apiResponse in
                
                self.empData = apiResponse
                
                                            for item in apiResponse.devices {
                
                                                print("id = \(item.id), deviceName = \(item.deviceName), productType = \(item.productType.rawValue)")
                
                                            }
                
            }
        }
    }
    
}
