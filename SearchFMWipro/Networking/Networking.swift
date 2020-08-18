//
//  Networking.swift
//  SeaarchFMWipro
//
//
//  Created by AG on 14/08/20.
//  Copyright © 2020 AG. All rights reserved.
//

import Foundation


struct Networking {
    
    func performNetworkTaskForLastFMAPI<T: Codable>(endpoint: LastFmAPI,
                                            type: T.Type,
                                            completion: ((_ response: T?, _ success:Bool) -> Void)?) {
           let urlString = endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
            
            guard let urlRequest = urlString?.getCleanedURL() else { return }
            print("Network API === \(urlRequest)")
            let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
                if let _ = error {
                    completion?(nil,false)
                    return
                }
                guard let data = data else {
                    completion?(nil,false)
                    return
                }
                let response = Response(data: data)
                
                let decoded = response.decode(type)
                if let object = decoded {
                    completion?(object,true)
                } else {
                    completion?(decoded,false)
                }
               
            }
            urlSession.resume()
        }
    

}
