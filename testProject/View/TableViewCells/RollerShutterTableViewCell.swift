//
//  RollerShutterTableViewCell.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import UIKit

class RollerShutterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    public func configureRollerShutterCell(rollerShutterModel: RollerShutter) {
        self.textLabel?.text = rollerShutterModel.deviceName
        if rollerShutterModel.position == 0 {
            self.detailTextLabel?.text = "mode - closed"
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
        else if rollerShutterModel.position == 100 {

            self.detailTextLabel?.text = "mode - fully opened, opened at \(rollerShutterModel.position)%"
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
        else{
            self.detailTextLabel?.text = " opened at \(rollerShutterModel.position)%"
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
    }
}
