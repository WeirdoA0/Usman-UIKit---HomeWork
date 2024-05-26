//
//  MockDataTaskService.swift
//  NetworkServiceTests
//
//  Created by Руслан Усманов on 10.05.2024.
//

import Foundation
@testable import NetworkService

class MockDataTaskService: IDataTaskService{
    var error: Error? = nil
    var responce: URLResponse?
    var data: Data?
    
    func completeRequest(request: URLRequest, completion: @escaping (Data?, URLResponse?, (any Error)?) -> Void) {
        completion(data, responce, error)
    }
    
}

enum MockError: Error {
    case mockError
}
