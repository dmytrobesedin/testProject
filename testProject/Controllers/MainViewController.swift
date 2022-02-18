//
//  ViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tableView = UITableView()
    private var devicesViewModel: DevicesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: - setup tableview
        tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerFooterView")
        view.addSubview(tableView)
         

        tableView.dataSource = self
        tableView.delegate = self
        
        callToViewModelForUpdate()

    }
    
    
    private func callToViewModelForUpdate(){
        self.devicesViewModel = DevicesViewModel()
        self.devicesViewModel.bindDevicesViewModelToController = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}



extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesViewModel.deviceData?.devices.count  ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
     configureCell(cell: cell, indexPath: indexPath)

//        cell.textLabel?.text =  heaterDeviceList?.deviceName
//        cell.detailTextLabel?.text = heaterDeviceList?.productType.rawValue // productType.rawValue
        
        return cell
    }
    
    
    
    
 private   func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
        let devicesList = devicesViewModel.deviceData?.devices[indexPath.row]
        switch devicesList?.productType {
        case .heater:
            if let heaterDevice = devicesList as? Heater {
                if heaterDevice.mode == .on{
                    cell.textLabel?.text = "\(heaterDevice.deviceName)"
                    cell.detailTextLabel?.text = "mode - \(heaterDevice.mode.rawValue) at \(heaterDevice.temperature)°C"
                    cell.imageView?.image = UIImage(named: "DeviceHeaterOnIcon")
                }
                else{
                    cell.textLabel?.text = "\(heaterDevice.deviceName)"
                    cell.detailTextLabel?.text = "mode - \(heaterDevice.mode.rawValue)"
                    cell.imageView?.image = UIImage(named: "DeviceHeaterOffIcon")
                }
            }
        case .light:
            if let lightDevice = devicesList as? Light {
                if lightDevice.mode == .on{
                    cell.textLabel?.text = lightDevice.deviceName
                    cell.detailTextLabel?.text = "mode - \(lightDevice.mode.rawValue) at \(lightDevice.intensity)%"
                    cell.imageView?.image = UIImage(named: "DeviceLightOnIcon")
                }
                else
                {
                    cell.textLabel?.text = "\(lightDevice.deviceName)"
                    cell.detailTextLabel?.text = "mode - \(lightDevice.mode.rawValue)"
                    cell.imageView?.image = UIImage(named: "DeviceLightOffIcon")
                }
            }
        case .rollerShutter:
            if  let rollerShutterDevice = devicesList as? RollerShutter {
                if rollerShutterDevice.position == 0 {
            cell.textLabel?.text = "\(rollerShutterDevice.deviceName)"
            cell.detailTextLabel?.text = "mode - closed"
                    cell.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
                }
                else if rollerShutterDevice.position == 100 {
                    cell.textLabel?.text = "\(rollerShutterDevice.deviceName)"
                    cell.detailTextLabel?.text = "mode - fully opened, opened at \(rollerShutterDevice.position)%"
                    cell.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
                }
                else{
                    cell.textLabel?.text = "\(rollerShutterDevice.deviceName)"
                    cell.detailTextLabel?.text = " opened at \(rollerShutterDevice.position)%"
                    cell.imageView?.image = UIImage(named: "DeviceRollerShutterIcon")
                }
            }
        case .none:
            cell.textLabel?.text = "textLabel"
            cell.detailTextLabel?.text  = "detailTextLabel"
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    
        guard let lightDevices = devicesViewModel.deviceData?.devices[indexPath.row] as? Light else{return}


   
     //   viewController.lightDevice = devicesList
       
       // self.navigationController?.viewControllers
        let vc = LightDetailViewController()
        
        
        vc.lightViewModel = LightViewModel(lightDataModel: lightDevices)
        vc.view.backgroundColor = .brown
        navigationController?.pushViewController(vc, animated: false)
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

