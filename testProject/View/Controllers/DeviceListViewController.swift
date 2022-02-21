//
//  ViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit

class DeviceListViewController: UIViewController {
    
    private var deviceListTableView: UITableView = {
        let tableview = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableview.register(LightTableViewCell.self, forCellReuseIdentifier: "lightCell")
        tableview.register(HeaterTableViewCell.self, forCellReuseIdentifier: "heaterCell")
        tableview.register(RollerShutterTableViewCell.self, forCellReuseIdentifier: "rollerShutterCell")
        return tableview
    }()
    private var devicesViewModel: DevicesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   deviceListTableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        
        
        
        
        // tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerFooterView")
        view.addSubview(deviceListTableView)
        
        
        deviceListTableView.dataSource = self
        deviceListTableView.delegate = self
        
        callToViewModelForUpdate()
        
    }
    
    private func setupTableView() {
        
    }
    
    
    private func callToViewModelForUpdate() {
        self.devicesViewModel = DevicesViewModel()
        self.devicesViewModel.bindDevicesViewModelToController = { [weak self] in
            DispatchQueue.main.async {
                self?.deviceListTableView.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension DeviceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesViewModel.deviceData?.devices.count  ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let devicesList = devicesViewModel.deviceData?.devices[indexPath.row] else{ return UITableViewCell() }
        switch devicesList.productType {
        case .light:
            if let lightDevice = devicesList as? Light{
                guard var lightCell = tableView.dequeueReusableCell(withIdentifier: "lightCell", for: indexPath) as? LightTableViewCell else{return LightTableViewCell()}
                lightCell = LightTableViewCell(style: .subtitle, reuseIdentifier: "lightCell")
                lightCell.configureLightCell(lightModel: lightDevice)
                return lightCell
            }
        case .heater:
            if let heaterDevice = devicesList as? Heater{
                guard var heaterCell = tableView.dequeueReusableCell(withIdentifier: "heaterCell", for: indexPath) as? HeaterTableViewCell else{return HeaterTableViewCell()}
                heaterCell = HeaterTableViewCell(style: .subtitle, reuseIdentifier: "heaterCell")
                heaterCell.configureHeaterCell(heaterModel: heaterDevice)
                return heaterCell
            }
        case .rollerShutter:
            if let rollerShutterDevice = devicesList as? RollerShutter{
                guard var rollerShutterCell = tableView.dequeueReusableCell(withIdentifier: "rollerShutterCell", for: indexPath) as? RollerShutterTableViewCell else{return RollerShutterTableViewCell()}
                rollerShutterCell = RollerShutterTableViewCell(style: .subtitle, reuseIdentifier: "rollerShutterCell")
                rollerShutterCell.configureRollerShutterCell(rollerShutterModel: rollerShutterDevice)
                return rollerShutterCell
            }
            
            
        }
        
        
        
        // guard    var cell  = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath)  as? DeviceTableViewCell else{return DeviceTableViewCell()}
        //    cell = DeviceTableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        // return   configureCell(cell: cell, indexPath: indexPath)
        
        //  return cell
        
        
        
        return UITableViewCell()
    }
    
    
    //    private  func configureCell(cell: DeviceTableViewCell, indexPath: IndexPath)  {
    //         let devicesList = devicesViewModel.deviceData?.devices[indexPath.row] else { return }
    //
    //        cell.textLabel?.text = "\(devicesList.deviceName)"
    //        switch devicesList.productType {
    //        case .heater:
    //            if let heaterDevice = devicesList as? Heater {
    //
    //                if heaterDevice.mode == .on {
    //                    cell.detailTextLabel?.text = "mode - \(heaterDevice.mode.rawValue) at \(heaterDevice.temperature)°C"
    //                    cell.imageView?.image = UIImage(named: "DeviceHeaterOnIcon")
    //                }
    //                else{
    //                    //                    cell.textLabel?.text = "\(heaterDevice.deviceName)"
    //                    cell.detailTextLabel?.text = "mode - \(heaterDevice.mode.rawValue)"
    //                    cell.imageView?.image = UIImage(named: "DeviceHeaterOffIcon")
    //                }
    //            }
    //        case .light:
    //            var  cellLight = tableView.dequeueReusableCell(withIdentifier: "lightCell", for: indexPath) as? LightTableViewCell
    //
    //            cellLight = LightTableViewCell(style: .subtitle, reuseIdentifier: "lightCell")
    //
    //
    //            if let lightDevice = devicesList as? Light {
    //
    //                cellLight?.configureLightCell(lightModel: lightDevice)
    //
    //            return cellLight
    //        case .rollerShutter:
    //            if  let rollerShutterDevice = devicesList as? RollerShutter {
    //                //                cell.textLabel?.text = "\(rollerShutterDevice.deviceName)"
    //                if rollerShutterDevice.position == 0 {
    //
    //                    cell.detailTextLabel?.text = "mode - closed"
    //                    cell.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
    //                }
    //                else if rollerShutterDevice.position == 100 {
    //
    //                    cell.detailTextLabel?.text = "mode - fully opened, opened at \(rollerShutterDevice.position)%"
    //                    cell.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
    //                }
    //                else{
    //
    //                    cell.detailTextLabel?.text = " opened at \(rollerShutterDevice.position)%"
    //                    cell.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
    //                }
    //            }
    //        }
    //    }
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        guard let device = devicesViewModel.deviceData?.devices[indexPath.row]  else{return}
        
        switch device.productType {
        case .light:
            guard let lightDevice = device as? Light else{return}
            let vc = LightDetailViewController()
            vc.lightViewModel = LightViewModel(lightDataModel: lightDevice)
            vc.view.backgroundColor = .white
            navigationController?.pushViewController(vc, animated: false)
        case .heater:
            guard let heaterDevice = device as? Heater else{return}
            let vc = HeaterDetailViewController()
            vc.heaterViewModel = HeaterViewModel(heaterDataModel:  heaterDevice)
            vc.view.backgroundColor = .white
            navigationController?.pushViewController(vc, animated: false)
        case .rollerShutter:
            guard let rollerShutterDevice = device as? RollerShutter else{return}
            let vc = RollerShutterDetailViewController()
            vc.rollerShutterViewModel = RollerShutterViewModel(rollerShutterDataModel: rollerShutterDevice)
            vc.view.backgroundColor = .white
            navigationController?.pushViewController(vc, animated: false)

        }
        
        //   viewController.lightDevice = devicesList
        
        // self.navigationController?.viewControllers
//        let vc = LightDetailViewController()
//        
//        
//        vc.lightViewModel = LightViewModel(lightDataModel: lightDevices)
//        vc.view.backgroundColor = .white
//        navigationController?.pushViewController(vc, animated: false)
        //self.navigationController?.pushViewController(vc, animated: false)
        
        
        
        // present(navigationController?, animated: true, completion: nil)
    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let  header  =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerFooterView")
    //        header?.textLabel?.text = devicesViewModel.empData?.devices[section].productType.rawValue
    //        return header
    //
    //    }
}

