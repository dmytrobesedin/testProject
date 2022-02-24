//
//  APIService.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation


class APIService: NSObject {
    static let urlString = "http://storage42.com/modulotest/data.json"
    //  let userDefaults  = UserDefaults.standard
    let url = URL(string: urlString)!
    
    func apiToGetDeviceData(completion : @escaping (ModulotestAPIResponse ) -> ()){
//        if  UserDefaults.standard.isKeyPresentInUserDefaults(key: "id"){
//            guard let data  = UserDefaults.standard.auth(forKey: "id") else {return }
//            completion(data)
//        }else{
            let dataTask =  URLSession.shared.dataTask(with: url) { (data, urlResponse, anotherError) in
                guard let data = data  else{return}
                
                let jsonDecoder = JSONDecoder()
                do {
                    let decodeData = try jsonDecoder.decode(ModulotestAPIResponse.self, from: data)

                    completion(decodeData)
                }
                catch (let error){
                    print("errorrr \(error)")
                }
            }
            dataTask.resume()
     //   }
    }
    
}


