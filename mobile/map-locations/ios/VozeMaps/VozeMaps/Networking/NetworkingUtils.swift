//
//  NetworkingUtils.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
}

/// Represents a single endpoint in the API
struct Route<Request: Encodable, Response: Decodable> {
    let method: HTTPMethod
    let path: String
    let queryItems: [URLQueryItem]? = nil
    let body: Request? = nil
    
    enum HTTPMethod: String {
        case GET, POST, PUT, DELETE
    }
}

/// For GET and DELETE requests
struct EmptyPayload: Encodable {}
