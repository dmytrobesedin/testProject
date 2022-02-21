//
//  HeaterDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import UIKit

class HeaterDetailViewController: UIViewController {
    private  var heaterTemperatureLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Temperature:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  var heaterTemperatureSlider: UISlider = {
        var slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        slider.minimumValue = 7.0
        slider.maximumValue = 28.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private  var heaterModeLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Mode:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  var heaterModeSwitch: UISwitch = {
        var modeSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        return modeSwitch
    }()
    
    
    
    public var heaterViewModel:HeaterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add subview
        self.view.addSubview(heaterModeLabel)
        self.view.addSubview(heaterModeSwitch)
        self.view.addSubview(heaterTemperatureLabel)
        self.view.addSubview(heaterTemperatureSlider)
        
        // add Target
        heaterTemperatureSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        heaterModeSwitch.addTarget(self, action:  #selector(switchValueChanged), for: .valueChanged)
        
        // setUp
        setUpConstraints()
        setUpValues()
        
    }
    
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            heaterModeSwitch.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heaterModeSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            heaterModeSwitch.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            heaterModeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            heaterModeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heaterModeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor ),
            heaterModeLabel.firstBaselineAnchor.constraint(equalTo: heaterModeSwitch.lastBaselineAnchor),
            heaterModeLabel.firstBaselineAnchor.constraint(equalTo: heaterModeSwitch.lastBaselineAnchor),
            
            heaterTemperatureLabel.topAnchor.constraint(equalTo: heaterModeLabel.bottomAnchor, constant: 25),
            heaterTemperatureLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor ),
            heaterTemperatureLabel.centerYAnchor.constraint(equalTo:heaterTemperatureSlider.centerYAnchor, constant: 5),
            heaterTemperatureLabel.firstBaselineAnchor.constraint(equalTo: heaterTemperatureSlider.lastBaselineAnchor),
            
            heaterTemperatureSlider.topAnchor.constraint(equalTo: heaterModeSwitch.bottomAnchor, constant: 30),
            heaterTemperatureSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            heaterTemperatureSlider.leadingAnchor.constraint(equalTo: heaterTemperatureLabel.trailingAnchor, constant: 8)
        ])
        
        
        
    }
    private   func setUpValues() {
        navigationItem.title  = heaterViewModel?.deviceName
        heaterTemperatureSlider.setValue(Float(heaterViewModel?.temperature ?? 7), animated: false)
        if heaterViewModel?.mode == .on {
            heaterModeSwitch.setOn(true, animated: false)
        } else {
            heaterModeSwitch.setOn(false, animated: false)
        }
    }
    
    
    @objc func sliderValueChanged(sender: UISlider) {
        guard sender != nil else {return  }
        let step: Float = 5
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        var heaterData = heaterViewModel?.heaterDataModel.temperature
        heaterData = Int(sender.value)
        print(sender.value)
        
    }
    
    @objc func switchValueChanged(sender: UISwitch){
        guard sender != nil else {return  }
        guard var heaterData = heaterViewModel?.heaterDataModel.mode  else {return }
        if sender.isOn {
            heaterData = .on
        }
        else{
            heaterData = .off
        }
        print(heaterData)
    }
    
    
    
}
