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

        // tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerFooterView")
        view.addSubview(deviceListTableView)
        
        
        deviceListTableView.dataSource = self
        deviceListTableView.delegate = self
        
        
        
        
        
    
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        callToViewModelForUpdate()

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
        
//        
//        if let deviceUserDefaults = devicesViewModel.userDefaultManager.retrieveData () {
//            print("result = \(deviceUserDefaults.devices[indexPath.row].productType)")
//        }
//        
//         let deviceUserDefaultsList = deviceUserDefaults.devices[indexPath.row]
//    
//        print(deviceUserDefaultsList)
        
        
        
        
      guard   let devicesList = devicesViewModel.deviceData?.devices[indexPath.row] else{ return UITableViewCell() }
        
        
     //   guard   let devicesList = devicesViewModel.userDefaultManager.retrieveData() else{ return UITableViewCell() }
      //  let devices = devicesList.devices[indexPath.row]
        switch devicesList.productType {
        
        case .light:
            if let lightDevice = devicesList as? Light{
                guard var lightCell = tableView.dequeueReusableCell(withIdentifier: "lightCell", for: indexPath) as? LightTableViewCell else{return LightTableViewCell()}
                lightCell = LightTableViewCell(style: .subtitle, reuseIdentifier: "lightCell")
                let lightViewModel = LightViewModel(lightDataModel: lightDevice)
                lightCell.configureLightCell(lightViewModel: lightViewModel)
                return lightCell
            }
        case .heater:
            if let heaterDevice = devicesList as? Heater{
                guard var heaterCell = tableView.dequeueReusableCell(withIdentifier: "heaterCell", for: indexPath) as? HeaterTableViewCell else{return HeaterTableViewCell()}
                heaterCell = HeaterTableViewCell(style: .subtitle, reuseIdentifier: "heaterCell")
                let heaterViewModel = HeaterViewModel(heaterDataModel: heaterDevice)
                heaterCell.configureHeaterCell(heaterViewModel: heaterViewModel)
                return heaterCell
            }
        case .rollerShutter:
            if let rollerShutterDevice = devicesList as? RollerShutter{
                guard var rollerShutterCell = tableView.dequeueReusableCell(withIdentifier: "rollerShutterCell", for: indexPath) as? RollerShutterTableViewCell else{return RollerShutterTableViewCell()}
                rollerShutterCell = RollerShutterTableViewCell(style: .subtitle, reuseIdentifier: "rollerShutterCell")
                let rollerShutterViewModel = RollerShutterViewModel(rollerShutterDataModel: rollerShutterDevice)
                rollerShutterCell.configureRollerShutterCell(rollerShutterViewModel:rollerShutterViewModel )
                return rollerShutterCell
            }
            
            
        }
        return UITableViewCell()
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard let device = devicesViewModel.deviceData?.devices[indexPath.row] else{return}
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
    }
}

