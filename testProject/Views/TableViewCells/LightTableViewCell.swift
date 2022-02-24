//
//  LightTableViewCell.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import UIKit

class LightTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureLightCell(lightViewModel: LightViewModel) {
        
        self.textLabel?.text = "\(lightViewModel.deviceName)".localized()
        if lightViewModel.mode == .on{
            self.detailTextLabel?.text = "mode - \(lightViewModel.mode.rawValue) at ".localized() + "\(lightViewModel.intensity)%"
            self.imageView?.image = UIImage(named: "DeviceLightOnIcon")
        }
        else
        {
            self.detailTextLabel?.text = "mode - \(lightViewModel.mode.rawValue)".localized()
            self.imageView?.image = UIImage(named: "DeviceLightOffIcon")
        }
    }
}
