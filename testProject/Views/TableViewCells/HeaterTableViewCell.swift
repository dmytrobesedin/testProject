//
//  HeaterTableViewCell.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import UIKit

class HeaterTableViewCell: UITableViewCell {
    static let heaterIdentifier = "heaterCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configureHeaterCell(heaterViewModel: HeaterViewModel) {
        self.textLabel?.text = heaterViewModel.deviceName.localized()
        if heaterViewModel.mode == .on {
            self.detailTextLabel?.text = "mode - \(heaterViewModel.mode.rawValue) at ".localized() + "\(heaterViewModel.temperature)°C"
            self.imageView?.image = UIImage(named: "DeviceHeaterOnIcon")
        }
        else {
            self.detailTextLabel?.text = "mode - \(heaterViewModel.mode.rawValue)".localized()
            self.imageView?.image = UIImage(named: "DeviceHeaterOffIcon")
        }
    }
}


