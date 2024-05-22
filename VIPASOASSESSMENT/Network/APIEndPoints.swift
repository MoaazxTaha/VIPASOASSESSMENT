//
//  APIEndPoints.swift
//  VIPASOASSESSMENT
//
//  Created by Moaaz Ahmed Fawzy Taha on 21/05/2024.
//

import Foundation
import RxSwift

enum API {
     case UsersList(searchTerm: String)
     case userDetails(username: String)
}

extension API: Endpoint {
    
    var base: String {
        return Config.baseURL
    }
    
    var prefix: String {
        switch self {
            case .UsersList:
                return "/search/users"
            case .userDetails:
                return "/user"
        }
    }
    
    var path: String {
        switch self {
            case .UsersList:
                return ""
            case .userDetails(let username):
                return "/\(username)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .UsersList,
                    .userDetails:
                return .GET
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .userDetails:
            return []
            case .UsersList(let query):
                return [.init(name: "q", value: query)]
        }
    }
    
    func request<T: Codable>() -> Single<T> {
        return URLSession.shared.rx.response(request: urlRequest)
            .map { response, data in
                guard 200 ..< 300 ~= response.statusCode else {
                    throw NetworkError(errorCode: response.statusCode)
                }

                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw NetworkError.dataParsingFailure
                }
            }
            .asSingle()
    }
    
    static func request<T: Codable>(url: URL, method: HTTPMethod = .GET) -> Single<T> {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return URLSession.shared.rx.response(request: request)
            .map { response, data in
                guard 200 ..< 300 ~= response.statusCode else {
                    throw NetworkError(errorCode: response.statusCode)
                }

                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw NetworkError.dataParsingFailure
                }
            }
            .asSingle()
    }
}
