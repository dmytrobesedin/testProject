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
    
    public func configureLightCell(lightModel: Light) {
        
        self.textLabel?.text = "\(lightModel.deviceName)"
        if lightModel.mode == .on{
            self.detailTextLabel?.text = "mode - \(lightModel.mode.rawValue) at \(lightModel.intensity)%"
            self.imageView?.image = UIImage(named: "DeviceLightOnIcon")
        }
        else
        {
            self.detailTextLabel?.text = "mode - \(lightModel.mode.rawValue)"
            self.imageView?.image = UIImage(named: "DeviceLightOffIcon")
        }
    }
}
