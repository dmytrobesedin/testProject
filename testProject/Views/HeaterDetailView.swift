//
//  HeaterDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import UIKit

class HeaterDetailView: UIViewController {
	// MARK: UI
	private lazy var heaterTemperatureLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.font = .preferredFont(forTextStyle: .body)
		label.text = Heater.CodingKeys.temperature.rawValue.localized()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var heaterTemperatureSlider: UISlider = {
		var slider = UISlider(frame: .zero)
		slider.minimumValue = 7.0
		slider.maximumValue = 28.0
		slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
		slider.setValue(Float(heaterViewModel.temperature), animated: false)
		slider.translatesAutoresizingMaskIntoConstraints = false
		return slider
	}()

	private lazy var heaterModeLabel: UILabel = {
		var label = UILabel(frame: .zero)
		label.font = .preferredFont(forTextStyle: .body)
		label.text = Heater.CodingKeys.mode.rawValue.localized()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var heaterModeSwitch: UISwitch = {
		var modeSwitch = UISwitch(frame: .zero)
		modeSwitch.addTarget(self, action:  #selector(switchValueChanged), for: .valueChanged)
		modeSwitch.translatesAutoresizingMaskIntoConstraints = false
		return modeSwitch
	}()

	// MARK: - Properties
	var heaterViewModel: HeaterViewModel

	// MARK: - Init
	init(heaterViewModel: HeaterViewModel) {
		self.heaterViewModel = heaterViewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Memory Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		setupValues()
	}
}
// MARK: - Setup Methods
private extension HeaterDetailView {
	func setup() {
		setupInterface()
		setupConstraints()
	}

	func setupInterface() {
		view.backgroundColor = .white
		navigationItem.title  = heaterViewModel.deviceName
		view.addSubview(heaterModeLabel)
		view.addSubview(heaterModeSwitch)
		view.addSubview(heaterTemperatureLabel)
		view.addSubview(heaterTemperatureSlider)
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			// HeaterModeSwitch
			heaterModeSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			heaterModeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
			heaterModeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			// HeaterModeLabel
			heaterModeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			heaterModeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			heaterModeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
			heaterModeLabel.firstBaselineAnchor.constraint(equalTo: heaterModeSwitch.lastBaselineAnchor),
			heaterModeLabel.firstBaselineAnchor.constraint(equalTo: heaterModeSwitch.lastBaselineAnchor),

			// HeaterTemperatureLabel
			heaterTemperatureLabel.topAnchor.constraint(equalTo: heaterModeLabel.bottomAnchor, constant: 25),
			heaterTemperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
			heaterTemperatureLabel.centerYAnchor.constraint(equalTo:heaterTemperatureSlider.centerYAnchor, constant: 5),
			heaterTemperatureLabel.firstBaselineAnchor.constraint(equalTo: heaterTemperatureSlider.lastBaselineAnchor),

			// heaterTemperatureSlider
			heaterTemperatureSlider.topAnchor.constraint(equalTo: heaterModeSwitch.bottomAnchor, constant: 30),
			heaterTemperatureSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			heaterTemperatureSlider.leadingAnchor.constraint(equalTo: heaterTemperatureLabel.trailingAnchor, constant: 8)
		])
	}

	func setupValues() {
		switch heaterViewModel.mode {
		case .on:
			heaterModeSwitch.setOn(true, animated: false)
		case .off:
			heaterModeSwitch.setOn(false, animated: false)
		}
	}
}

// MARK: - Selector methods
@objc private extension HeaterDetailView {
	func sliderValueChanged(sender: UISlider) {
		let step: Float = 5
		let roundedValue = round(sender.value / step) * step
		sender.value = roundedValue
		heaterViewModel.setUpHeaterTemperature(value: sender.value)
	}

	func switchValueChanged(sender: UISwitch) {
		let heaterValue: Bool
		switch sender.isOn {
		case true:
			heaterValue = true

		case false:
			heaterValue = false
		}
		heaterViewModel.setUpHeaterMode(value: heaterValue)
	}
}

