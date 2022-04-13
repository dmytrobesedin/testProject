//
//  DevicesViewModelDelegate.swift
//  testProject
//
//  Created by Дмитрий Беседин on 24.03.2022.
//
import UIKit
import Foundation

protocol DevicesViewModelDelegate: AnyObject {
    func didFinishUpdatingData()
    func didFinishConfiguringVC(_ vc: UIViewController)
}
