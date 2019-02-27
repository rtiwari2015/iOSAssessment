//
//  NetworkManager.swift
//  iOSAssessment
//
//  Created by Dev on 26/02/19.
//  Copyright © 2019 DevApp. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration:self.configuration)
    var URL: URL
    
    typealias CompletionType = (Data?) -> Void
    
    init(url: URL) {
        self.URL = url
    }
    
    /**
     Downloads the data from url and sends data.
     */
    mutating func downloadDataFromURL(completion: @escaping CompletionType) {
        
        let request = URLRequest(url: self.URL)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            completion(data)
        });
        task.resume()
    }
}
