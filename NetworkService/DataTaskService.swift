//
//  DataTaskService.swift
//  NetworkService
//
//  Created by Руслан Усманов on 10.05.2024.
//

import Foundation

public protocol IDataTaskService {
    func completeRequest(request: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void)
}

public class DataTaskService: IDataTaskService {
    
    public init(){}
    
    public func completeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request){data,response,error in
            completion(data, response, error)
        }
        dataTask.resume()
    }
}

