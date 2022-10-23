//
//  HeaterViewModel.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import Foundation
import UIKit

final class HeaterViewModel {
	// MARK: - Properties
	public var id: Int {
		return heaterDataModel.id
	}
	public var temperature: Int {
		return heaterDataModel.temperature
	}
	public var mode: Mode {
		return heaterDataModel.mode
	}
	public var deviceName: String {
		return heaterDataModel.deviceName
	}
	public var productType: String {
		return heaterDataModel.productType.rawValue
	}
	
	// MARK: - Private properties
	private var heaterDataModel: Heater
	private var heaterVC: UIViewController?
	private var userDefaultsManager: UserDefaultsManagerProtocol?
	
	// MARK: - Init
	required init(device: Heater) {
		self.heaterDataModel = device
		self.heaterVC = HeaterDetailView(heaterViewModel: self)
		self.userDefaultsManager = UserDefaultsManager()
	}
	
	// MARK: - Methods
	public func setUpHeaterTemperature(value: Float) {
		let key = "\(self.id)|\(Heater.CodingKeys.temperature.rawValue)"
		userDefaultsManager?.setUpSliderValue(key, value)
	}
	public func setUpHeaterMode(value: Bool) {
		let key = "\(self.id)|\(Heater.CodingKeys.mode.rawValue)"
		userDefaultsManager?.setUpSwitchValue(key, value)
	}
}

// MARK: - DeviceViewModelProtocol
extension HeaterViewModel: DeviceViewModelProtocol {
	func configureDeviceVC() -> UIViewController {
		guard let vc = heaterVC else {
			let vc = HeaterDetailView(heaterViewModel: self)
			self.heaterVC = vc
			return vc
		}
		return vc
	}
}
