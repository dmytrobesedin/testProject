//
//  Localization.swift
//  testProject
//
//  Created by Дмитрий Беседин on 22.02.2022.
//

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
        
    }
}
