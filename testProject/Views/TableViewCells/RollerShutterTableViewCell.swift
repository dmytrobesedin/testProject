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
    
    public func configureRollerShutterCell(rollerShutterViewModel: RollerShutterViewModel) {
        self.textLabel?.text = rollerShutterViewModel.deviceName.localized()
        if rollerShutterViewModel.position == 0 {
            self.detailTextLabel?.text = "mode - closed".localized()
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
        else if rollerShutterViewModel.position == 100 {
            self.detailTextLabel?.text = "mode - fully opened,".localized() + " opened at ".localized() + "\(rollerShutterViewModel.position)%"
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
        else{
            self.detailTextLabel?.text = "opened at ".localized() + "\(rollerShutterViewModel.position)%"
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
    }
}
