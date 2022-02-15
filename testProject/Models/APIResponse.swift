//
//  Data.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation


// MARK: - Data
class APIResponse: Codable {
    var devices: [Device]
    let user: User

    init(devices: [Device], user: User) {
        self.devices = devices
        self.user = user
    }
}
