//
//  HeaterDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import UIKit

class HeaterDetailView: UIViewController {
    private var heaterTemperatureLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Heater.CodingKeys.temperature.rawValue.localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var heaterTemperatureSlider: UISlider = {
        var slider = UISlider(frame: .zero)
        slider.minimumValue = 7.0
        slider.maximumValue = 28.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private var heaterModeLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Heater.CodingKeys.mode.rawValue.localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var heaterModeSwitch: UISwitch = {
        var modeSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        return modeSwitch
    }()
    
    var heaterViewModel:HeaterViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addDetailHeaterSubviews()
        
        // add target
        heaterTemperatureSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        heaterModeSwitch.addTarget(self, action:  #selector(switchValueChanged), for: .valueChanged)
        
        // setUp
        setUpConstraints()
        setUpValues()
    }
    
    init(heaterViewModel: HeaterViewModel) {
        self.heaterViewModel = heaterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addDetailHeaterSubviews() {
        self.view.addSubview(heaterModeLabel)
        self.view.addSubview(heaterModeSwitch)
        self.view.addSubview(heaterTemperatureLabel)
        self.view.addSubview(heaterTemperatureSlider)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            heaterModeSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heaterModeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            heaterModeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heaterModeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heaterModeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heaterModeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            heaterModeLabel.firstBaselineAnchor.constraint(equalTo: heaterModeSwitch.lastBaselineAnchor),
            heaterModeLabel.firstBaselineAnchor.constraint(equalTo: heaterModeSwitch.lastBaselineAnchor),
            
            heaterTemperatureLabel.topAnchor.constraint(equalTo: heaterModeLabel.bottomAnchor, constant: 25),
            heaterTemperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            heaterTemperatureLabel.centerYAnchor.constraint(equalTo:heaterTemperatureSlider.centerYAnchor, constant: 5),
            heaterTemperatureLabel.firstBaselineAnchor.constraint(equalTo: heaterTemperatureSlider.lastBaselineAnchor),
            
            heaterTemperatureSlider.topAnchor.constraint(equalTo: heaterModeSwitch.bottomAnchor, constant: 30),
            heaterTemperatureSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heaterTemperatureSlider.leadingAnchor.constraint(equalTo: heaterTemperatureLabel.trailingAnchor, constant: 8)
        ])
    }
    
    private func setUpValues() {
        navigationItem.title  = heaterViewModel.deviceName
        heaterTemperatureSlider.setValue(Float(heaterViewModel.temperature), animated: false)
        if heaterViewModel.mode == .on {
            heaterModeSwitch.setOn(true, animated: false)
        } else {
            heaterModeSwitch.setOn(false, animated: false)
        }
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        let step: Float = 5
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        heaterViewModel.setUpHeaterTemperature(value: sender.value)
    }
    
    @objc func switchValueChanged(sender: UISwitch){
        let heaterValue:Bool
        if sender.isOn {
            heaterValue = true
        }
        else{
            heaterValue = false
        }
        heaterViewModel.setUpHeaterMode(value: heaterValue)
    }
}

