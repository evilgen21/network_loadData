//
//  NetworkM.swift
//
//  Created by Евгений Сабина on 11.05.24.
//


import Foundation

enum APIRoutes {

    case getTodos
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .getTodos:
            return "todos"
        }
    }

    var method: String {
        switch self {
        case .getTodos:
            return "GET"
        }
    }
    
    var request: URLRequest {
        
        let url = URL(string: path, relativeTo: baseURL)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}

class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
       
    func getTodos(completion: @escaping (Result<[todos], Error>) -> Void) {
        
        let requst = APIRoutes.getTodos.request
        
        let task = URLSession.shared.dataTask(with: requst) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data, let Base = try? JSONDecoder().decode([todos].self, from: data) {
                completion(.success(Base))
            }
            else {
                completion(.success([]))
            }
        }
        
        task.resume()
    }
}
