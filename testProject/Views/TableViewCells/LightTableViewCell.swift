//
//  LightTableViewCell.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import UIKit

class LightTableViewCell: UITableViewCell {
    static let lightIdentifier = "lightCell"
    
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
    
    public func configureCell(lightViewModel: LightViewModel) {
        self.textLabel?.text = "\(lightViewModel.deviceName)".localized()
        if lightViewModel.mode == .on{
            self.detailTextLabel?.text = "mode - \(lightViewModel.mode.rawValue) at ".localized() + "\(lightViewModel.intensity)%"
            self.imageView?.image = UIImage(named: "DeviceLightOnIcon")
        }
        else{
            self.detailTextLabel?.text = "mode - \(lightViewModel.mode.rawValue)".localized()
            self.imageView?.image = UIImage(named: "DeviceLightOffIcon")
        }
    }
}
