//
//  Request.swift
//  CoinBalance
//
//  Created by Taylor Masterson on 2/1/18.
//  Copyright © 2018 Taylor Masterson. All rights reserved.
//

import UIKit


public class Request: NSObject {
    public let session = URLSession.shared
    public let parameters: [String: String]
    public let initiated: Date?
    
    public init(_ parameters: Dictionary<String, String> = [:]) {
        self.parameters = parameters
        self.initiated = Date()
    }
    
    public func fetchCoins(_ handler: @escaping ([CoinData]) -> Void) {
        fetch { (results, error) in
            if error != nil {
                print(error)
                print("do somethign with this error")
                return
            }
            var coins = [CoinData]()
            coins = results as! [CoinData]
            
            handler(coins)
        }
    }
    
    public typealias PropertyList = Any
    public func fetch(_ handler: @escaping (PropertyList?, NSError?) -> Void) {
        performRequest(.GET, handler: handler)
    }
    
    public func performRequest(_ method: MethodType, handler: @escaping (PropertyList?, NSError?) -> Void) {
        let url = buildURL(withParameters: parameters)
        let request = requestWithHeaders(url, method: method)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if !self.statusCodeSuccessful(response) { return }
            guard let data = data else { return }
            
            do {
                let responseData = try JSONDecoder().decode([CoinData].self, from: data)
                handler(responseData, nil)
            } catch {
                let userInfo = [NSLocalizedDescriptionKey: error]
                handler(nil, NSError(domain: "performRequest", code: 1, userInfo: userInfo))
            }
        }
        task.resume()
    }
}

extension Request {
    
    private func requestWithHeaders(_ url: URL, method: MethodType) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        return request
    }
    
    private func buildURL(withParameters parameters: [String: String]?) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = RequestConstants.APIScheme
        urlComponents.host = APIConstants.APIHost
        urlComponents.path = APIConstants.APIPath
        
        if let params = parameters {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems!.append(queryItem)
            }
        }
        
        return urlComponents.url!
    }
    
    private func statusCodeSuccessful(_ response: URLResponse?) -> Bool {
        let successRange: Range<Int> = 200..<300
        guard let statusCode = ( response as? HTTPURLResponse)?.statusCode, successRange ~= statusCode else {
            return false
        }
        return true
    }
}

extension Request {
    public enum MethodType: String {
        case GET
        case POST
        case PATCH
        case PUT
        case DELETE
    }
    
    private struct RequestConstants {
        static let APIScheme = "https"
    }
    
    private struct APIConstants {
        static let APIHost = "api.coinmarketcap.com"
        static let APIPath = "/v1/ticker/"
    }
    
}
