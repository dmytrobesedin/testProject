//
//  UserDefaults.swift
//  testProject
//
//  Created by Дмитрий Беседин on 22.02.2022.
//

import Foundation

extension UserDefaults {
	// MARK: - Methods
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func cleanUserDefaults() {
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
    }
}
