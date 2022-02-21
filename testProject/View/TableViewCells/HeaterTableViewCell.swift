//
//  HeaterTableViewCell.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import UIKit

class HeaterTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    public func configureHeaterCell(heaterModel: Heater) {
        self.textLabel?.text = heaterModel.deviceName
        if heaterModel.mode == .on {
            self.detailTextLabel?.text = "mode - \(heaterModel.mode.rawValue) at \(heaterModel.temperature)°C"
            self.imageView?.image = UIImage(named: "DeviceHeaterOnIcon")
        }
        else{
            self.detailTextLabel?.text = "mode - \(heaterModel.mode.rawValue)"
            self.imageView?.image = UIImage(named: "DeviceHeaterOffIcon")
            
        }
    }
}


