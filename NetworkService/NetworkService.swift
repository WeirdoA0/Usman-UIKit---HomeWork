//
//  NetworkService.swift
//  NetworkService
//
//  Created by Руслан Усманов on 17.01.2024.
//

import Foundation


public final class NetworkService {
    public let service: IDataTaskService
    public var resultStatus: ResultStatus?
    public init(service: IDataTaskService) {
        self.service = service
    }
    
    public func request(url: URL) {
        let request: URLRequest = URLRequest(url: url)
        service.completeRequest(request: request) { [weak self] data, response, error in
            if let error  {
                print(error.localizedDescription)
                self?.resultStatus = .requestError
                return
            }
            if let HTTPSResopnse = response as? HTTPURLResponse {
                switch HTTPSResopnse.statusCode {
                case 200:
                    guard let data  else {
                        print("Failed to decode")
                        self?.resultStatus = .empty
                        return
                    }
                    self?.resultStatus = .success
                    let dataToPrint = String(decoding: data, as: UTF8.self)
                    let statusCode = HTTPSResopnse.statusCode
                    let headerFields = HTTPSResopnse.allHeaderFields
                    print(dataToPrint, statusCode, headerFields )
                    
                case 404:
                    self?.resultStatus = .badResponce
                    print("Not found")
                default:
                    self?.resultStatus = .badResponce
                    print("Unowed")
                }
            }
        }
    }
}


public enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people"
    case starships = "https://swapi.dev/api/starships"
    case planets = "https://swapi.dev/api/planets"
    
    public var url: URL? {
        URL(string: self.rawValue)
    }
}
public enum ResultStatus {
    case requestError
    case badResponce
    case success 
    case empty
}




