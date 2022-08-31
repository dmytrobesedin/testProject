//
//  APIService.swift
//  testProject
//
//  Created by Дмитрий Беседин on 15.02.2022.
//

import Foundation

 final class APIService: NSObject {
	// MARK: - Constants
    static let urlString = "http://storage42.com/modulotest/data.json"

	// MARK: - Private properties
    private let url = URL(string: urlString)!

	// MARK: - Methods
    func apiToGetDeviceData(completion : @escaping (ModulotestAPIResponse) -> ()) {
        let dataTask = URLSession.shared.dataTask(with:url) { (data, urlResponse, anotherError) in
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
    }
}


