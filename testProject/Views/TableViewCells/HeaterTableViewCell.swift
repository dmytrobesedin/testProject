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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(heaterViewModel: HeaterViewModel) {
        self.textLabel?.text = heaterViewModel.deviceName.localized()
        if heaterViewModel.mode == .on {
            self.detailTextLabel?.text = "mode - \(heaterViewModel.mode.rawValue) at".localized() + " " + "\(heaterViewModel.temperature)°C"
            self.imageView?.image = UIImage(named: "DeviceHeaterOnIcon")
        }
        else {
            self.detailTextLabel?.text = "mode - \(heaterViewModel.mode.rawValue)".localized()
            self.imageView?.image = UIImage(named: "DeviceHeaterOffIcon")
        }
    }
}


