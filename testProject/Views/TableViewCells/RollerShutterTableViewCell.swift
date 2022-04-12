//
//  RollerShutterTableViewCell.swift
//  testProject
//
//  Created by Дмитрий Беседин on 20.02.2022.
//

import UIKit

class RollerShutterTableViewCell: UITableViewCell {
    static let rollerShutterIdentifier = "rollerShutterCell"
    private let modeClosed =  "mode - closed"
    private let modeFullyOpened = "mode - fully opened,"
    private let openedAt = "opened at"
    
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
    
    public func configureCell(rollerShutterViewModel: RollerShutterViewModel) {
        self.textLabel?.text = rollerShutterViewModel.deviceName.localized()
        if rollerShutterViewModel.position == 0 {
            self.detailTextLabel?.text = modeClosed.localized()
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
        else if rollerShutterViewModel.position == 100 {
            self.detailTextLabel?.text = modeFullyOpened.localized() + " " + openedAt.localized() + " " + "\(rollerShutterViewModel.position)%"
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
        else{
            self.detailTextLabel?.text = openedAt.localized() + " " + "\(rollerShutterViewModel.position)%"
            self.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
        }
    }
}
