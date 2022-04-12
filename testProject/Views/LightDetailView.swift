//
//  LightDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 17.02.2022.
//

import UIKit

class LightDetailView: UIViewController {
    private var intensityLabel: UILabel = {
        var label = UILabel(frame:.zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Light.CodingKeys.intensity.rawValue.localized() // не кто так не делает 
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var intensitySlider: UISlider = {
        var intensitySlider = UISlider(frame: .zero)
        intensitySlider.minimumValue = 0.0
        intensitySlider.maximumValue = 100.0
        intensitySlider.translatesAutoresizingMaskIntoConstraints = false
        return intensitySlider
    }()
    
    private var modeLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Light.CodingKeys.mode.rawValue.localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var modeSwitch: UISwitch = {
        var modeSwitch = UISwitch(frame: .zero)
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        return modeSwitch
    }()
    
    var lightViewModel: LightViewModel
    
    init(lightViewModel: LightViewModel) {
        self.lightViewModel = lightViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // addTarget
        intensitySlider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        modeSwitch.addTarget(self, action: #selector(changeSwitch), for: .valueChanged)
        
        addDetailLightSubviews()
        
        // setUp
        setUpValue()
        setUpConstraints()
    }
    
    private func addDetailLightSubviews() {
        view.addSubview(intensityLabel)
        view.addSubview(intensitySlider)
        view.addSubview(modeLabel)
        view.addSubview(modeSwitch)
    }
    
    private func setUpValue() {
        navigationItem.title  = lightViewModel.deviceName
        intensitySlider.setValue(Float(lightViewModel.intensity), animated: false)
        if lightViewModel.mode == .on {
            modeSwitch.setOn(true, animated: false)
        } else {
            modeSwitch.setOn(false, animated: false)
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            intensityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            intensityLabel.firstBaselineAnchor.constraint(equalTo: intensitySlider.lastBaselineAnchor),
            intensityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            intensityLabel.centerYAnchor.constraint(equalTo: intensitySlider.centerYAnchor),
            
            intensitySlider.trailingAnchor.constraint(equalTo: view.trailingAnchor ),
            intensitySlider.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 8),
            intensitySlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            modeLabel.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 30),
            modeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            modeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modeLabel.firstBaselineAnchor.constraint(equalTo: modeSwitch.lastBaselineAnchor),
            
            modeSwitch.topAnchor.constraint(equalTo: intensitySlider.bottomAnchor, constant: 30),
            modeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            modeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func changeSlider(sender: UISlider){
        lightViewModel.setUpLightIntensity(value: sender.value) // нюанс
    }
    
    @objc private func changeSwitch(sender: UISwitch){
        let lightValue: Bool
        if sender.isOn {
            lightValue = true
        }
        else{
            lightValue = false
        }
        lightViewModel.setUpLightMode(value: lightValue)
    }
}

