//
//  LightDetailViewController.swift
//  testProject
//
//  Created by Дмитрий Беседин on 17.02.2022.
//

import UIKit

class LightDetailViewController: UIViewController {

    
    private var deviceNameLabel: UILabel = {
        let deviceNameLabel = UILabel(frame: .zero)
        deviceNameLabel.font = .preferredFont(forTextStyle: .body)
 //      leftLabel.numberOfLines = 0
        deviceNameLabel.backgroundColor = .white
        deviceNameLabel.text = "device Name: "
        deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
    //    leftLabel.numberOfLines = 0
        return deviceNameLabel
    }()
    private var deviceNameDataTextField:UITextField = {
        let deviceLabel = UITextField(frame: .zero)
    //    rightLabel.font = .preferredFont(forTextStyle: .body)
      //  rightLabel.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        deviceLabel.backgroundColor = .white
      
        deviceLabel.translatesAutoresizingMaskIntoConstraints = false
        return deviceLabel
    }()
    private var intensityLabel: UILabel = {
        let intensityLabel = UILabel(frame: .zero)
       // intensityLabel.font = .preferredFont(forTextStyle: .body)
 //      leftLabel.numberOfLines = 0
        intensityLabel.backgroundColor = .white
        intensityLabel.text = "intensity :  "
        intensityLabel.translatesAutoresizingMaskIntoConstraints = false
    //    leftLabel.numberOfLines = 0
        return intensityLabel
    }()
    private var intensityLabelData: UITextField = {
        let intensityLabelData = UITextField(frame: .zero)
    //    rightLabel.font = .preferredFont(forTextStyle: .body)
      //  rightLabel.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        intensityLabelData.backgroundColor = .white
        intensityLabelData.translatesAutoresizingMaskIntoConstraints = false
        return intensityLabelData
    }()
    
    private var modeLabel : UILabel = {
        let modeLabel = UILabel(frame: .zero)
       // modeLabel.font = .preferredFont(forTextStyle: .body)
 //      leftLabel.numberOfLines = 0
        modeLabel.backgroundColor = .white
        modeLabel.text = "Mode: "
        modeLabel.translatesAutoresizingMaskIntoConstraints = false
    //    leftLabel.numberOfLines = 0
        return modeLabel
    }()
    private var modeStatus: UITextField = {
        let modeStatus = UITextField(frame: .zero)
    //
//modeStatus.font = .preferredFont(forTextStyle: .body)
      //
       // modeStatus.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        modeStatus.backgroundColor = .white
      
        
        modeStatus.translatesAutoresizingMaskIntoConstraints = false
        return modeStatus
    }()
    
    
    
    
    let rootStackView = UIStackView()
    let deviceNameStackView = UIStackView()
    let intensityStackView = UIStackView()
    let modeStackView = UIStackView()
     var lightViewModel: LightViewModel?
    var label =  UILabel()
    var textField = UITextView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.storyboard?. instantiateViewController(withIdentifier: <#T##String#>)
   //     self.storyboard?. instantiateViewController(withIdentifier: "LightDetailViewController")
        
        // Do any additional setup after loading the view.
        //view.backgroundColor = .blue
        //StackView
       // view.translatesAutoresizingMaskIntoConstraints = false
//               let stack = UIStackView()
//
//                stack.axis = .vertical
//               stack.distribution = .fillEqually
//               stack.alignment = .center
//               stack.spacing = 5
//        stack.backgroundColor = .blue
//
//
       // let examlpeView = UIView()
     //  examlpeView.translatesAutoresizingMaskIntoConstraints = false
       // examlpeView.backgroundColor = .green
//
//
//        let stackView = UIStackView()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .green
//        textField.backgroundColor  = .yellow
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)
//        view.addSubview(textField)
//
//
//
        
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .fill
        rootStackView.distribution = .fill
        rootStackView.spacing = 8
        
//
        
        
        
        deviceNameStackView.translatesAutoresizingMaskIntoConstraints = false
        deviceNameStackView.backgroundColor = .white
        deviceNameStackView.axis = .horizontal
        deviceNameStackView.alignment = .firstBaseline
        deviceNameStackView.distribution = .fill
        deviceNameStackView.spacing = 8
        
        
        intensityStackView.translatesAutoresizingMaskIntoConstraints = false
        intensityStackView.backgroundColor = .white
        intensityStackView.axis = .horizontal
        intensityStackView.alignment = .firstBaseline
        intensityStackView.distribution = .fill
        intensityStackView.spacing = 8
        
        
        
        modeStackView.translatesAutoresizingMaskIntoConstraints = false
        modeStackView.backgroundColor = .white
        modeStackView.axis = .horizontal
        modeStackView.alignment = .firstBaseline
        modeStackView.distribution = .fill
        modeStackView.spacing = 8
        
        
        
        
        guard let mode = lightViewModel?.lightDataModel.mode.rawValue  else {
            return
        }
        guard let intensity = lightViewModel?.lightDataModel.intensity  else {
            return
        }
        
        deviceNameDataTextField.text = lightViewModel?.lightDataModel.deviceName
        intensityLabelData.text = String( intensity )
        modeStatus.text = mode
        
        print(lightViewModel?.lightDataModel.intensity)
        
        
        
        print(lightViewModel?.lightDataModel.mode.rawValue)
        
        
        deviceNameStackView.addSubview(deviceNameDataTextField)
        deviceNameStackView.addSubview(deviceNameLabel)
        intensityStackView.addSubview(intensityLabel)
        intensityStackView.addSubview(intensityLabelData)
        modeStackView.addSubview(modeLabel)
        modeStackView.addSubview(modeStatus)
        
//        deviceNameStackView.addSubview(label1)
//        deviceNameStackView.addSubview(label2)
      rootStackView.addSubview(deviceNameStackView)
//        rootStackView.addSubview(leftLabel)
  rootStackView.addSubview(intensityStackView)
        rootStackView.addSubview(modeStackView)
        rootStackView.backgroundColor = .green
        view.addSubview(rootStackView)

        let padding: CGFloat = 20
        let multiplier: CGFloat  = 1.0
       
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//
//
//            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
//            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
//        ])
//
//
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        
            
            
            
            deviceNameStackView.topAnchor.constraint(equalTo: rootStackView.safeAreaLayoutGuide.topAnchor, constant: padding),
            deviceNameStackView.leadingAnchor.constraint(equalTo: rootStackView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            deviceNameStackView.centerXAnchor.constraint(equalTo: rootStackView.centerXAnchor),
            deviceNameStackView.heightAnchor.constraint(equalToConstant: 40),
            
            
            
            
            intensityStackView.topAnchor.constraint(equalTo: deviceNameStackView.bottomAnchor, constant: padding),
            intensityStackView.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor, constant: padding),
            intensityStackView.centerXAnchor.constraint(equalTo: rootStackView.centerXAnchor),
            intensityStackView.heightAnchor.constraint(equalToConstant: 40),
            
            modeStackView.topAnchor.constraint(equalTo: intensityStackView.bottomAnchor, constant: padding),
            modeStackView.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor, constant: padding),
            modeStackView.centerXAnchor.constraint(equalTo: rootStackView.centerXAnchor),
            modeStackView.heightAnchor.constraint(equalToConstant: 40),
            
            
            
            
            deviceNameLabel.leadingAnchor.constraint(equalTo: deviceNameStackView.leadingAnchor ),
            deviceNameDataTextField.trailingAnchor.constraint(equalTo: deviceNameStackView.trailingAnchor ),
            deviceNameDataTextField.leadingAnchor.constraint(equalTo: deviceNameLabel.trailingAnchor, constant: 8),
            deviceNameDataTextField.topAnchor.constraint(equalTo: deviceNameStackView.safeAreaLayoutGuide.topAnchor),
            deviceNameLabel.firstBaselineAnchor.constraint(equalTo: deviceNameDataTextField.lastBaselineAnchor),
            
            
            intensityLabel.leadingAnchor.constraint(equalTo: intensityStackView.leadingAnchor ),
            intensityLabelData.trailingAnchor.constraint(equalTo: intensityStackView.trailingAnchor ),
            intensityLabelData.leadingAnchor.constraint(equalTo: intensityLabel.trailingAnchor, constant: 28),
            intensityLabelData.topAnchor.constraint(equalTo: intensityStackView.safeAreaLayoutGuide.topAnchor),
            intensityLabel.firstBaselineAnchor.constraint(equalTo: intensityLabelData.lastBaselineAnchor),
            
            
            
            modeLabel.leadingAnchor.constraint(equalTo: modeStackView.leadingAnchor ),
            modeStatus.trailingAnchor.constraint(equalTo: modeStackView.trailingAnchor ),
            modeStatus.leadingAnchor.constraint(equalTo: modeLabel.trailingAnchor, constant: 50),
            modeStatus.topAnchor.constraint(equalTo: modeStackView.safeAreaLayoutGuide.topAnchor),
            modeLabel.firstBaselineAnchor.constraint(equalTo: modeStatus.lastBaselineAnchor)
           
            
            
            
            
            
//            label1.leadingAnchor.constraint(equalTo: deviceNameStackView.leadingAnchor ),
//            label2.trailingAnchor.constraint(equalTo: deviceNameStackView.trailingAnchor ),
//            label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor, constant: 8),
//            label2.topAnchor.constraint(equalTo: leftLabel.safeAreaLayoutGuide.topAnchor),
//            label1.firstBaselineAnchor.constraint(equalTo: label2.lastBaselineAnchor)
//
//
            
        ])
        
        
        
//            examlpeView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            examlpeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            examlpeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            examlpeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            examlpeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            examlpeView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
//            examlpeView.widthAnchor.constraint(equalToConstant: 80),
//            examlpeView.heightAnchor.constraint(equalToConstant: 50),
//
            
           // examlpeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            //    examlpeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//                examlpeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            examlpeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//              examlpeView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//examlpeView.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20)
//
            
           // examlpeView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
           // examlpeView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            
            // examlpeView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: multiplier),
         //   view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: examlpeView.bottomAnchor, multiplier: multiplier)
    
        
  //    label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
     //      label.textAlignment = .center
        
        
        
        
   //   setupLabel()
        
      //  self.label.text = lightViewModel?.intensity
//        stack.addArrangedSubview(label)
//        stack.addArrangedSubview(label)
//        
      //  view.addSubview(label)
        //view.addSubview(label)
        navigationItem.title = "LightDetail"
       // funcToUpdateViewModel()
        
        
        
//        stack.translatesAutoresizingMaskIntoConstraints  = false
//                stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//                stack.centerXAnchor.constraint(equalTo : self.view.centerXAnchor).isActive = true
    }
    
    
    

    
    
    
    
    func setupLabel()  {
       
        let constraints = [
            view.centerXAnchor.constraint(equalTo:  self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo:  self.view.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate([
        
        
        
        
        ])

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
