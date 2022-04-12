//
//  RollerShutterDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import UIKit

class RollerShutterDetailView: UIViewController {
    private var rollerShutterPositionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = RollerShutter.CodingKeys.position.rawValue.localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var rollerShutterPositionSlider: UISlider = {
        var slider = UISlider(frame:.zero)
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.makeVertical()
        return slider
    }()
    
    var rollerShutterViewModel: RollerShutterViewModel
    
    init(rollerShutterViewModel:RollerShutterViewModel) {
        self.rollerShutterViewModel = rollerShutterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addShutterDetailSubviews()
        
        // addTarget
        rollerShutterPositionSlider.addTarget(self, action: #selector(changeRollerShutter), for: .valueChanged)
        
        navigationItem.title = rollerShutterViewModel.deviceName
        rollerShutterPositionSlider.setValue(Float(rollerShutterViewModel.position), animated: false)
        setUpConstraints()
    }
    
    private func addShutterDetailSubviews() {
        view.addSubview(rollerShutterPositionLabel)
        view.addSubview(rollerShutterPositionSlider)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            rollerShutterPositionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            rollerShutterPositionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rollerShutterPositionLabel.centerYAnchor.constraint(equalTo: rollerShutterPositionSlider.centerYAnchor, constant: 0), //  const = -150
            
            rollerShutterPositionSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            rollerShutterPositionSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -150),
            rollerShutterPositionSlider.leadingAnchor.constraint(equalTo: rollerShutterPositionLabel.trailingAnchor, constant: -150 )
        ])
    }
    
    @objc func changeRollerShutter(sender: UISlider)  {
        rollerShutterViewModel.setUpRollerShutterPosition(value: sender.value)
    }
}
