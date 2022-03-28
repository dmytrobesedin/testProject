//
//  ViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit

class DeviceListView: UIViewController {
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
        addDevicesListSubviews()
        
        // subscribe delegate
        devicesListTableView.dataSource = self
        devicesListTableView.delegate = self
        devicesViewModel.devicesViewModelDelegate = self
        
        // load  data
        loadDataFromViewModel()
        
        // delete items from UserDefaults
        // devicesViewModel.userDefaultManager?.cleanUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateSelectedRow(isSelectedRow)
    }
    
    private func addDevicesListSubviews() {
        view.addSubview(devicesListTableView)
    }
    
    private func updateSelectedRow(_ isSelected: Bool)  {
        if isSelected {
            devicesViewModel.updateData()
        }
    }
    
    private func loadDataFromViewModel() {
        self.devicesViewModel.connectDevicesViewModelToController = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async{
                self.devicesListTableView.reloadData()
            }
        }
    }
}

func configureCell(_ device: Device,_ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell? {
    switch device.productType {
    case .light:
        if let lightDevice = device as? Light{
            guard var lightCell = tableView.dequeueReusableCell(withIdentifier: "lightCell", for: indexPath) as? LightTableViewCell else{return nil}
            lightCell = LightTableViewCell(style: .subtitle, reuseIdentifier: "lightCell")
            let lightViewModel = LightViewModel(device: lightDevice)
            lightCell.configureLightCell(lightViewModel: lightViewModel)
            return lightCell
        }
    case .heater:
        if let heaterDevice = device as? Heater{
            guard var heaterCell = tableView.dequeueReusableCell(withIdentifier: "heaterCell", for: indexPath) as? HeaterTableViewCell else{return nil}
            heaterCell = HeaterTableViewCell(style: .subtitle, reuseIdentifier: "heaterCell")
            let heaterViewModel = HeaterViewModel(device: heaterDevice)
            heaterCell.configureHeaterCell(heaterViewModel: heaterViewModel)
            return heaterCell
        }
    case .rollerShutter:
        if let rollerShutterDevice = device as? RollerShutter{
            guard var rollerShutterCell = tableView.dequeueReusableCell(withIdentifier: "rollerShutterCell", for: indexPath) as? RollerShutterTableViewCell else{return nil}
            rollerShutterCell = RollerShutterTableViewCell(style: .subtitle, reuseIdentifier: "rollerShutterCell")
            let rollerShutterViewModel = RollerShutterViewModel(device: rollerShutterDevice)
            rollerShutterCell.configureRollerShutterCell(rollerShutterViewModel:rollerShutterViewModel )
            return rollerShutterCell
        }
    }
    return UITableViewCell()
}



// MARK: - UITableViewDelegate, UITableViewDataSource
extension DeviceListView: UITableViewDelegate, UITableViewDataSource, DevicesViewModelDelegate{
    
    func didFinishUpdatingData() {
        DispatchQueue.main.async {
            self.devicesListTableView.reloadRows(at: [self.selectedIndexPath], with: .none)
        }
        isSelectedRow = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesViewModel.deviceData?.devices.count  ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let device = devicesViewModel.deviceData?.devices[indexPath.row] else{ return UITableViewCell() }
        guard let configureCell = configureCell(device,indexPath,tableView) else{return UITableViewCell()}
        return configureCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSelectedRow = true
        selectedIndexPath = indexPath
        guard let device = devicesViewModel.deviceData?.devices[indexPath.row] else{return}
        devicesViewModel.configureVC(device)
    }
    func didFinishConfiguringVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

