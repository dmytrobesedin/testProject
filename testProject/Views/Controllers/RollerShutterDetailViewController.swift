//
//  RollerShutterDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 21.02.2022.
//

import UIKit

class RollerShutterDetailViewController: UIViewController {
    
    private  var rollerShutterPositionLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Position:".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private  var rollerShutterPositionSlider: UISlider = {
        var slider = UISlider(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.makeVertical()
        return slider
    }()
    
    
    var rollerShutterViewModel: RollerShutterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // addSubview
        self.view.addSubview(rollerShutterPositionLabel)
        self.view.addSubview(rollerShutterPositionSlider)
        
        
        // addTarget
        self.rollerShutterPositionSlider.addTarget(self, action: #selector(changeRollerShutter ), for: .valueChanged)
        
        
        
        self.navigationItem.title = rollerShutterViewModel?.deviceName
        rollerShutterPositionSlider.setValue(Float(rollerShutterViewModel?.position ?? 0), animated: false)
        setUpConstraints()
    }
    
    
    private  func setUpConstraints() {
        NSLayoutConstraint.activate([
            rollerShutterPositionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            rollerShutterPositionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            rollerShutterPositionLabel.centerYAnchor.constraint(equalTo: rollerShutterPositionSlider.centerYAnchor, constant: -150), //  const = 0
            
            rollerShutterPositionSlider.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 160),
            rollerShutterPositionSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -150),
            rollerShutterPositionSlider.leadingAnchor.constraint(equalTo: rollerShutterPositionLabel.trailingAnchor, constant: -150 )
            
        ])
    }
    
    
    @objc func changeRollerShutter(sender: UISlider)  {
        guard sender != nil else {return}
        
        guard let rollerShutterId = rollerShutterViewModel?.id  else {return}
        let key  = "\(rollerShutterId)|\(RollerShutter.CodingKeys.position.rawValue)"
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.setValue(Int(sender.value), forKey: key)
        
    }
}
