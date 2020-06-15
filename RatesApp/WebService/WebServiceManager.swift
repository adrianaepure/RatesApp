//
//  WebServiceManager.swift
//  RatesApp
//
//  Created by Adriana Epure on 13/06/2020.
//  Copyright © 2020 Adriana Epure. All rights reserved.
//

import Foundation
import Alamofire

public enum APIsource: String {
    case baseURL = "https://exchangeratesapi.io"
    case latestURL = "https://api.exchangeratesapi.io/latest"
}

public enum WebServiceManagerError: Error {
    case invalidURL(String)
    case parseError(String)
    case forwarded(Error)
}

public protocol WebServiceManagerProtocol {
    func fetchData<T>(for url:URL, completionHandler:(T, Error) -> Void)
}

public class WebServiceManager{
    func fetchData<T: Codable>(for url: URL, params: Parameters, completionHandler: @escaping (T?, Error?) -> Void){
        print("url: ", url)
        AF.request(url, parameters: params)
            .responseDecodable(of: T.self) { (response) in
                
                 if response.error != nil {
                    completionHandler(nil, response.error)
                }else{
                    if let parsedJSON = response.value {
                        completionHandler((parsedJSON), nil)
                    }
                }
        }
    }
}
