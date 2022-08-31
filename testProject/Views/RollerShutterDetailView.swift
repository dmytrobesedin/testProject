//
//  RollerShutterDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import UIKit

class RollerShutterDetailView: UIViewController {
	// MARK: - UI
    private lazy var rollerShutterPositionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = RollerShutter.CodingKeys.position.rawValue.localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rollerShutterPositionSlider: UISlider = {
        var slider = UISlider(frame:.zero)
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
		slider.addTarget(self, action: #selector(changeRollerShutter), for: .valueChanged)
		slider.setValue(Float(rollerShutterViewModel.position), animated: false)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.makeVertical()
        return slider
    }()

	// MARK: - Properties
    var rollerShutterViewModel: RollerShutterViewModel

	// MARK: - Init
    init(rollerShutterViewModel: RollerShutterViewModel) {
        self.rollerShutterViewModel = rollerShutterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	// MARK: - Memory Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
}

// MARK: - Setup Methods
private extension RollerShutterDetailView {
	 func setup()  {
		setupInterface()
		setupConstraints()
	}

     func setupInterface() {
		navigationItem.title = rollerShutterViewModel.deviceName
		view.backgroundColor = .white
        view.addSubview(rollerShutterPositionLabel)
        view.addSubview(rollerShutterPositionSlider)
    }
    
     func setupConstraints() {
        NSLayoutConstraint.activate([
			// RollerShutterPositionLabel
            rollerShutterPositionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            rollerShutterPositionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rollerShutterPositionLabel.centerYAnchor.constraint(equalTo: rollerShutterPositionSlider.centerYAnchor, constant: 0), //  const = -150

			// RollerShutterPositionSlider
            rollerShutterPositionSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 165),
            rollerShutterPositionSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -150),
            rollerShutterPositionSlider.leadingAnchor.constraint(equalTo: rollerShutterPositionLabel.trailingAnchor, constant: -150 )
        ])
    }
}

// MARK: - Selector methods
private extension RollerShutterDetailView {
    @objc func changeRollerShutter(sender: UISlider) {
        rollerShutterViewModel.setUpRollerShutterPosition(value: sender.value)
    }
}
