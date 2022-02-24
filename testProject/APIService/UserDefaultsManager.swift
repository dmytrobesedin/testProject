//
//  UserDefaultsManager.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import Foundation

class UserDefaultsManager: UserDefaults {
    let userDefaults = UserDefaults.standard
    
    func retrieveData() -> ModulotestAPIResponse?{
        do {
        guard let data = userDefaults.data(forKey: "id")  else{return nil}
            let decoder = JSONDecoder()
        guard let loadedData = try? decoder.decode(ModulotestAPIResponse.self, from: data) else{return nil}
        return loadedData
        } catch{
            print(error.localizedDescription)
            return nil
            
        }
    }

    
    func saveData(dataToSave: ModulotestAPIResponse)  {
        do {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(dataToSave)  else{return}
       userDefaults.set(encoded, forKey: "id")
        }catch{
            print(error.localizedDescription)
        }
    }
}
