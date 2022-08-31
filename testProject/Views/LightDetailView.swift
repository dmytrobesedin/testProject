//
//  LightDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 17.02.2022.
//

import UIKit

class LightDetailView: UIViewController {
	// MARK: - UI
    private lazy var intensityLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Light.CodingKeys.intensity.rawValue.localized() 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var intensitySlider: UISlider = {
        var intensitySlider = UISlider(frame: .zero)
        intensitySlider.minimumValue = 0.0
        intensitySlider.maximumValue = 100.0
		intensitySlider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
		intensitySlider.setValue(Float(lightViewModel.intensity), animated: false)
        intensitySlider.translatesAutoresizingMaskIntoConstraints = false
        return intensitySlider
    }()
    
    private lazy var modeLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Light.CodingKeys.mode.rawValue.localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var modeSwitch: UISwitch = {
        var modeSwitch = UISwitch(frame: .zero)
		modeSwitch.addTarget(self, action: #selector(changeSwitch), for: .valueChanged)
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        return modeSwitch
    }()

	// MARK: - Properties
    var lightViewModel: LightViewModel

	// MARK: - Init
    init(lightViewModel: LightViewModel) {
        self.lightViewModel = lightViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - Memory Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

		setupValue()
        setup()
    }
}

// MARK: - Setup Methods
private extension LightDetailView {
	 func setup() {
		setupInterface()
		setupConstraints()
	}

	 func setupInterface() {
		view.backgroundColor = .white
		navigationItem.title  = lightViewModel.deviceName
		view.addSubview(intensityLabel)
		view.addSubview(intensitySlider)
		view.addSubview(modeLabel)
		view.addSubview(modeSwitch)
	}

	 func setupValue() {
		 switch lightViewModel.mode {
		 case .on:
			 modeSwitch.setOn(true, animated: false)
		 case .off:
			 modeSwitch.setOn(false, animated: false)
		 }
	}

	 func setupConstraints() {
		NSLayoutConstraint.activate([
			//IntensityLabel
			intensityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
			intensityLabel.firstBaselineAnchor.constraint(equalTo: intensitySlider.lastBaselineAnchor),
			intensityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			intensityLabel.centerYAnchor.constraint(equalTo: intensitySlider.centerYAnchor),

			// IntensityLabel
			intensitySlider.trailingAnchor.constraint(equalTo: view.trailingAnchor ),
			intensitySlider.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 8),
			intensitySlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),

			// ModeLabel
			modeLabel.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 30),
			modeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
			modeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			modeLabel.firstBaselineAnchor.constraint(equalTo: modeSwitch.lastBaselineAnchor),

			// ModeSwitch
			modeSwitch.topAnchor.constraint(equalTo: intensitySlider.bottomAnchor, constant: 30),
			modeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
			modeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		])
	}
}

// MARK: - Selector methods
@objc private extension LightDetailView {
	 func changeSlider(sender: UISlider) {
		lightViewModel.setUpLightIntensity(value: sender.value)
	}

	func changeSwitch(sender: UISwitch) {
		let lightValue: Bool
		switch sender.isOn {
		case true:
			lightValue = true

		case false:
			lightValue = false
		}

		lightViewModel.setUpLightMode(value: lightValue)
	}
}
    


