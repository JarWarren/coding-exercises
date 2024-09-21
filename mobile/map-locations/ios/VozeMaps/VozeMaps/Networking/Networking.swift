//
//  APIService.swift
//  VozeMaps
//
//  Created by Jared Warren on 9/20/24.
//

import Foundation

// Using a class (but not a singleton) allows us to pass in different configurations
// ex. testing or prod vs dev
class Networking {
    private var baseURL: URL
    private var authToken: String?
    private let urlSession: URLSession
    
    init(
        baseURL: URL = URL(string: "https://github.com/JarWarren/coding-exercises/blob/master/mobile")!,
        authToken: String? = nil,
        urlSession: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.authToken = authToken
        self.urlSession = urlSession
    }
    
    
    func perform<RequestType: Encodable, ResponseType: Decodable>(
        _ route: Route<RequestType, ResponseType>
    ) async throws -> ResponseType {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(route.path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = route.queryItems
        
        guard let url = urlComponents?.url else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = route.body,
           !(body is EmptyPayload) {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingError.httpError(statusCode: httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(ResponseType.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkingError.decodingError(error)
        }
    }
}
