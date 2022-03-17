//
//  LightDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 17.02.2022.
//

import UIKit

class LightDetailViewController: UIViewController {
    
    
    private  var intensityLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Intensity:".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  var intensitySlider: UISlider = {
        var intensitySlider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        intensitySlider.minimumValue = 0.0
        intensitySlider.maximumValue = 100.0
        
        intensitySlider.translatesAutoresizingMaskIntoConstraints = false
        return intensitySlider
    }()
    
    private  var modeLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Mode:".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private  var modeSwitch: UISwitch = {
        var modeSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
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
        self.intensitySlider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        self.modeSwitch.addTarget(self, action: #selector(changeSwitch ), for: .valueChanged)
        
        
        // addSubviews
        self.view.addSubview(intensityLabel)
        self.view.addSubview(intensitySlider)
        self.view.addSubview(modeLabel)
        self.view.addSubview(modeSwitch)
        
        // setUp
        setUpValue()
        setUpConstraints()
    }
    
    
    private func setUpValue() {
        navigationItem.title  = lightViewModel.deviceName
        
        self.intensitySlider.setValue(Float(lightViewModel.intensity), animated: false)
        
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
            intensityLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor ),
            intensityLabel.centerYAnchor.constraint(equalTo: intensitySlider.centerYAnchor),
            
            intensitySlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor ),
            intensitySlider.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 8),
            intensitySlider.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            modeLabel.topAnchor.constraint(equalTo: intensityLabel.bottomAnchor, constant: 30),
            modeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor ),
            modeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            modeLabel.firstBaselineAnchor.constraint(equalTo: modeSwitch.lastBaselineAnchor),
            
            modeSwitch.topAnchor.constraint(equalTo: intensitySlider.bottomAnchor, constant: 30),
            modeSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            modeSwitch.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
     
    
    @objc private func changeSlider(sender: UISlider){
        guard sender != nil else {return}
        let key  = "\(lightViewModel.id)|\(Light.CodingKeys.intensity.rawValue)"
        lightViewModel.callFuncToSetUpLightIntensity(key: key, value: sender.value)
    }
    
    
  
    
    @objc  private func changeSwitch(sender: UISwitch){
        guard sender != nil else {return}
        let lightValue: Bool
        if sender.isOn {
            lightValue = true
        }
        else{
            lightValue = false
        }
        
        let key  = "\(lightViewModel.id)|\(Light.CodingKeys.mode.rawValue)"
        lightViewModel.callFuncToSetUpLightMode(key: key, value: lightValue)
    }
}
