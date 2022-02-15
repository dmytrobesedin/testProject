//
//  ViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var tableView = UITableView()
    private var devicesViewModel = DevicesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        

        tableView.dataSource = self
        tableView.delegate = self
        
        callToViewModelForUpdate()

    }
    
    
    
    
    private func callToViewModelForUpdate(){
      //  self.devicesViewModel = DevicesViewModel()
     
        self.devicesViewModel.bindDevicesViewModelToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
    }
   

}



extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devicesViewModel.empData?.devices.count ?? 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let deviceList = devicesViewModel.empData?.devices[indexPath.row]
        cell.textLabel?.text =  deviceList?.deviceName
        cell.detailTextLabel?.text = deviceList?.productType.rawValue
        
        return cell
    }
 
    
}

