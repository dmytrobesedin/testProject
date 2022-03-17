//
//  ViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit

class DeviceListViewController: UIViewController {
    
    private var devicesListTableView: UITableView = {
        let tableview = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableview.register(LightTableViewCell.self, forCellReuseIdentifier: "lightCell")
        tableview.register(HeaterTableViewCell.self, forCellReuseIdentifier: "heaterCell")
        tableview.register(RollerShutterTableViewCell.self, forCellReuseIdentifier: "rollerShutterCell")
        return tableview
    }()
    
    private var devicesViewModel: DevicesViewModel
    
    private var isSelectedRow = false
    private var selectedIndexPath = IndexPath(row: 0, section: 0)
    
    init(devicesViewModel:DevicesViewModel){
        self.devicesViewModel = devicesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // addSubview
        view.addSubview(devicesListTableView)
        
        // subscribe delegate
        devicesListTableView.dataSource = self
        devicesListTableView.delegate = self
        devicesViewModel.devicesViewModelDelegate = self
        
        // load  data
        callToViewModelForLoadData()
        
        // delete items from UserDefaults
        // devicesViewModel.userDefaultManager?.deleteFromUserDefaults()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        callToViewModelForUpdateSelectedRow(isSelectedRow)
    }
    
    
    private func callToViewModelForUpdateSelectedRow(_ isSelected: Bool)  {
        if isSelected {
            devicesViewModel.callFuncToUpdateData()
        }
    }
    
    
    
    private func callToViewModelForLoadData() {
        self.devicesViewModel.connectDevicesViewModelToController = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async{
                self.devicesListTableView.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension DeviceListViewController: UITableViewDelegate, UITableViewDataSource, DevicesViewModelDelegate{
    
    func didFinishUpdatingData() {
        DispatchQueue.main.async {
            self.devicesListTableView.reloadRows(at: [self.selectedIndexPath], with: .none)
        }
        self.isSelectedRow = false
        
    }
    
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
        isSelectedRow = true
        selectedIndexPath = indexPath
        guard let device = devicesViewModel.deviceData?.devices[indexPath.row] else{return}
        switch device.productType {
        case .light:
            guard let lightDevice = device as? Light else{return}
            let lightViewModel = LightViewModel(lightDataModel: lightDevice)
            let vc = LightDetailViewController(lightViewModel: lightViewModel)
            navigationController?.pushViewController(vc, animated: false)
        case .heater:
            guard let heaterDevice = device as? Heater else{return}
            let heaterViewModel = HeaterViewModel(heaterDataModel:  heaterDevice)
            let vc = HeaterDetailViewController(heaterViewModel: heaterViewModel)
            navigationController?.pushViewController(vc, animated: false)
        case .rollerShutter:
            guard let rollerShutterDevice = device as? RollerShutter else{return}
            let rollerShutterViewModel = RollerShutterViewModel(rollerShutterDataModel: rollerShutterDevice)
            let vc = RollerShutterDetailViewController(rollerShutterViewModel: rollerShutterViewModel)
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }
}

