//
//  LightDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 17.02.2022.
//

import UIKit

class LightDetailViewController: UIViewController {

    
    
     var lightViewModel: LightViewModel?
    var label =  UILabel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.storyboard?. instantiateViewController(withIdentifier: <#T##String#>)
   //     self.storyboard?. instantiateViewController(withIdentifier: "LightDetailViewController")
        
        // Do any additional setup after loading the view.
        //view.backgroundColor = .blue
        //StackView
        
               let stack = UIStackView()
        
                stack.axis = .vertical
               stack.distribution = .fillEqually
               stack.alignment = .center
               stack.spacing = 5
        stack.backgroundColor = .blue
        
        
        
        
      label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
           label.textAlignment = .center
      
        
        self.label.text = lightViewModel?.intensity
//        stack.addArrangedSubview(label)
//        stack.addArrangedSubview(label)
//        
        view.addSubview(label)
        //view.addSubview(label)
        navigationItem.title = "LightDetail"
       // funcToUpdateViewModel()
        
        
        
        stack.translatesAutoresizingMaskIntoConstraints  = false
                stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    func setupLabel()  {


    }
//
//    func funcToUpdateViewModel() {
//        self.lightViewModel = LightViewModel(
////        lightViewModel.bindDevicesViewModelToController = {
////
////        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
