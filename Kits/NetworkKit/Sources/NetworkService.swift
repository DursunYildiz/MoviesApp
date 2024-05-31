//
//  NetworkService.swift
//  NetworkKit
//
//  Created by Dursun YILDIZ on 29.05.2024.
//

import Combine
import Foundation
import UtilsKit
public final class NetworkService {
    public static let shared = NetworkService()
    private init() {}
        
    private var cancellables = Set<AnyCancellable>()
        
    public func makeRequest(endpoint: NetworkConstants.Endpoints, method: Method = .get, parameters: [String: String]? = nil) -> URLRequest? {
        guard var urlComponents = URLComponents(string: NetworkConstants.baseUrl.rawValue + endpoint.rawValue) else {
            return nil
        }
            
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
            
        guard let url = urlComponents.url else {
            return nil
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        request.setValue("Bearer \(NetworkConstants.apiKey.rawValue)", forHTTPHeaderField: "Authorization")
        Log.info(request.debugDescription)
        return request
    }

    public func makePostRequest<T: Encodable>(url: String, body: T? = nil) -> URLRequest? {
        guard let urlComponents = URLComponents(string: url) else {
            return nil
        }
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = Method.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            request.httpBody = jsonData
        } catch {
            Log.error("Failed to serialize JSON body: \(error.localizedDescription)")
            return nil
        }
        return request
    }
}
