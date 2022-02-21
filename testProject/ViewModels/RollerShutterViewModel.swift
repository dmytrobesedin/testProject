//
//  RollerShutterViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import Foundation

class RollerShutterViewModel {
    var rollerShutterDataModel: RollerShutter
   init(rollerShutterDataModel: RollerShutter) {
       self.rollerShutterDataModel = rollerShutterDataModel
   }
   
  public var position: Int {
    return rollerShutterDataModel.position
   }

   public var deviceName: String {
    return rollerShutterDataModel.deviceName
    }
   public var productType: String {
    return rollerShutterDataModel.productType.rawValue
    }
   
}
