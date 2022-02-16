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
     
        self.devicesViewModel.bindDevicesViewModelToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
    }
   

}



extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesViewModel.empData?.devices.count  ?? 1 //.count ?? 1 // devices.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let heaterDeviceList = devicesViewModel.empData?.devices[indexPath.row]

        cell.textLabel?.text =  heaterDeviceList?.deviceName
        cell.detailTextLabel?.text = heaterDeviceList?.productType.rawValue // productType.rawValue
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  header  =  tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerFooterView")
        header?.textLabel?.text = devicesViewModel.empData?.devices[section].productType.rawValue
        return header
        
    }
}

