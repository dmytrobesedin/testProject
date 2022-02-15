//
//  APIService.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation


class APIService: NSObject {
   static let urlString = "http://storage42.com/modulotest/data.json"
    let url = URL(string: urlString)!
    func apiToGetEmployeeData(completion : @escaping (APIResponse) -> ()){
       let dataTask =  URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
        guard let data = data  else{return}
                
                let jsonDecoder = JSONDecoder()
                
                let decodeData = try! jsonDecoder.decode(APIResponse.self, from: data)
                    completion(decodeData)
            
        }
        dataTask.resume()
    }
}

