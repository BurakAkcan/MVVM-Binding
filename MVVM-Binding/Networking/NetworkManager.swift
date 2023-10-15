//
//  NetworkManager.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 19.09.2023.
//

import Foundation
import Alamofire

enum MyResult<T> {
    case success(T)
    case failure(Error)
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let service = Service.shared
    
    private init() {}
    
    func getTrendingMovies(completion: @escaping (MyResult<Movie>) -> Void) {
        let requestHeader: [HTTPHeader] = [ HTTPHeader(name: "Authorization", value: "Bearer \(Constants.authToken)")]
        let request = ServiceRequest(endpoint: .trendMovie, method: .get, headers: requestHeader)
        
        service.request(request: request) { (result: ServiceResult<Movie>) in
            switch result {
            case .success(let movie):
                completion(.success(movie))
            case .failure(let serviceError):
                completion(.failure(serviceError))
            }
        }
    }
    
    // Diğer ağ çağrıları için benzer işlevleri ekleyebilirsiniz
}

