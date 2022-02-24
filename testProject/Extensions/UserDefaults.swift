//
//  UserDefaults.swift
//  testProject
//
//  Created by Дмитрий Беседин on 22.02.2022.
//

import Foundation




extension UserDefaults {
    func auth(forKey defaultName: String) -> ModulotestAPIResponse? {
        guard let data = data(forKey: defaultName) else { return nil }
        do {
            return try JSONDecoder().decode(ModulotestAPIResponse.self, from: data)
        } catch { print(error); return nil }
    }
    
    
    

    func set(_ value: ModulotestAPIResponse, forKey defaultName: String) {
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
