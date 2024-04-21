//
//  InfoViewControllerNetworkService.swift
//  NetworkService
//
//  Created by Руслан Усманов on 20.01.2024.
//

import Foundation


public class InfoViewControllerNetworkService {
    
    
    public init(){}
    
    //MARK: Public
    
    public func fetch(completion: @escaping(String) -> Void){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/") else {fatalError()
            
        }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request){data,response,error in
            if error != nil {
                fatalError("Connection error")
            }
            guard let HTTPResopnse = response as? HTTPURLResponse else {
                fatalError("No response")
            }
            switch HTTPResopnse.statusCode {
            case 200:
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data)
                        if let array = json as? [[String: Any]] {
                            let tittle =  array.randomElement()?["title"] as? String
                            completion(tittle ?? "error")
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            case 404:
                print("Not found")
                
            default:
                print("Unowned")
            }
        }
        dataTask.resume()
    }
    
    
    public func fetchTatooine(handlePeriod: @escaping(String) -> Void, handleResident: @escaping(String) -> Void){
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else {fatalError()
        }
        
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        let dataTask = URLSession.shared.dataTask(with: request){data,response,error in
            if error != nil {
                fatalError("Connection error")
                
            }
            guard let HTTPResopnse = response as? HTTPURLResponse else {
                fatalError("No response")
            }
            
            switch HTTPResopnse.statusCode {
            case 200:
                if let data = data {
                    do {
                        let planetData = try decoder.decode(TatooineData.self, from: data)
                        let residents = planetData.residents
                        handlePeriod(planetData.orbitalPeriod)
                        
                        self.fetchResidents(residentsStringURL: residents, completion: handleResident)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            case 404:
                print("Not found")
                
            default:
                print("Unowned")
            }
            
        }
        dataTask.resume()
    }
    
    
    //MARK: Private
    
    private func fetchResidents(residentsStringURL: [String], completion: @escaping(String) -> Void){

        for stringURL in residentsStringURL {
            guard let url = URL(string: stringURL) else { print("Bad request"); return }
                let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request, completionHandler: {  data, response, error in
                let decoder = JSONDecoder()
                if error != nil {
                    print("Connection error")
                }
                guard let HTTPResopnse = response as? HTTPURLResponse else {
                    print("no response")
                    return
                }
                switch HTTPResopnse.statusCode {
                case 200:
                    if let data = data {
                        do {
                            let resedent =  try decoder.decode(Resident.self, from: data)
                            let name = resedent.name
                            completion(name)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                case 404:
                    print("Not found")
                    
                default:
                    print("Unowned")
                }
            })
            dataTask.resume()
            }
        }
    
}

struct TatooineData: Decodable {
    let  orbitalPeriod : String
    let residents: [String]

    enum CodingKeys: String, CodingKey {
        case orbitalPeriod = "orbital_period"
        case residents
    }
}

struct Resident: Decodable {
    let name: String
}



