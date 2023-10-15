//
//  Service.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 19.09.2023.
//

import Foundation


import Foundation
import Alamofire

enum Endpoints: String {
    case trendMovie = "/3/trending/all/day"
}

enum ServiceResult<T> {
    case success(T)
    case failure(ServiceError)
}

struct ServiceRequest {
    var baseUrl: String = Constants.baseURL
    var endpoint: Endpoints
    var method: HTTPMethod
    var parameters: Parameters?
    var encoding: ParameterEncoding = URLEncoding.default
    var headers: [HTTPHeader]?
    var httpBody: Data?
}

enum ServiceError: Error {
    case generateUrl(internal: Error)
    case serializationError(internal: Error)
    case networkError(internal: Error, statusCode: Int?)
    case unknownError
}

final class Service {
    static let shared: Service = Service()
    
    private init() {}
    
    func request<T: Decodable>(request: ServiceRequest, completion: @escaping ((ServiceResult<T>) -> Void)) {
        do {
            let urlRequest = try generateUrl(request: request)
            
            AF.request(urlRequest).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(.networkError(internal: error, statusCode: response.response?.statusCode)))
                }
            }
        } catch let error {
            completion(.failure(ServiceError.generateUrl(internal: error)))
        }
    }
    
    func upload<T: Decodable>(request: ServiceRequest, fileURL: URL, paramName: String, fileName: String, completion: @escaping ((ServiceResult<T>) -> Void)) {
        do {
            let urlRequest = try self.generateUrl(request: request)
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(fileURL, withName: paramName, fileName: fileName, mimeType: "image/jpeg")
                
                if let parameters = request.parameters {
                    for (key, value) in parameters {
                        if let data = "\(value)".data(using: .utf8) {
                            multipartFormData.append(data, withName: key)
                        }
                    }
                }
            }, with: urlRequest)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(.networkError(internal: error, statusCode: response.response?.statusCode)))
                }
            }
        } catch let error {
            completion(.failure(.generateUrl(internal: error)))
        }
    }
    
    private func generateUrl(request: ServiceRequest) throws -> URLRequest {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = request.baseUrl
        urlComponent.path = request.endpoint.rawValue
        var urlRequest = URLRequest(url: urlComponent.url!)
        // For Headers
        if let headers = request.headers {
            for header in headers {
                urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
            }
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }else {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpMethod = request.method.rawValue
        return try request.encoding.encode(urlRequest, with: request.parameters)
    }
}
