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
    
    
    
    public   var lightViewModel: LightViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        navigationItem.title  = lightViewModel?.deviceName
        self.intensitySlider.setValue(Float(lightViewModel?.intensity ?? 0), animated: false)
        
        if lightViewModel?.mode == .on {
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
    
    override func viewWillLayoutSubviews() {
        
    }
    
    @objc func changeSlider(sender: UISlider){
        guard sender != nil else {return}
        guard let lightId = lightViewModel?.id  else {return}
        let key  = "\(lightId)|\(Light.CodingKeys.intensity.rawValue)"
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.setValue(Int(sender.value), forKey: key)
    }
    
    
    @objc func changeSwitch(sender: UISwitch){
        guard sender != nil else {return  }
        let lightData: Bool
        if sender.isOn {
            lightData = true
        }
        else{
            lightData = false
        }
        guard let lightId = lightViewModel?.id  else {return}
        let key  = "\(lightId)|\(Light.CodingKeys.mode.rawValue)"
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.setValue(lightData, forKey: key)
    }
}
