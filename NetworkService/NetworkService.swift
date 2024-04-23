//
//  NetworkService.swift
//  NetworkService
//
//  Created by Руслан Усманов on 17.01.2024.
//

import Foundation


public struct NetworkService {
    public static func request(url: URL) {
        let session = URLSession.shared
        let request: URLRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: request){data,response,erorr in
            if let erorr = erorr {
                print(erorr.localizedDescription)
                return
            }
            if let HTTPSResopnse = response as? HTTPURLResponse {
                switch HTTPSResopnse.statusCode {
                case 200:
                    guard let data = data else { print("Failed to decode"); return }
                    let dataToPrint = String(decoding: data, as: UTF8.self)
                    let statusCode = HTTPSResopnse.statusCode
                    let headerFields = HTTPSResopnse.allHeaderFields
                    print(dataToPrint, statusCode, headerFields)
                    
                case 404:
                    print("Not found")
                default:
                    print("Unowed")
                }
            }
        }
        dataTask.resume()
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




