//
//  WebService.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class Webservice: NetworkService {
    
    //MARK: - Properties
    private var session: URLSession
    static let shared = Webservice(session: .shared)
    
    //MARK: - Init
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    //MARK: - Generic API Call request execution and logging
    func makeRequest<T: Decodable>(config: RequestConfig, responseType: T.Type) async throws -> T {
        //Logging request
        Logger.printRequest(url: config.url, httpMethod: config.httpMethod, headers: config.httpHeaders, params: config.httpParams)
        
        //Create URLrequest
        var request = URLRequest(url: config.url)
        request.httpMethod = config.httpMethod.rawValue
        
        //Adding HTTP headers (optional)
        if let headers = config.httpHeaders {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        //Adding params (optional - for POST methods)
        if let params = config.httpParams, config.httpMethod == .post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                throw NetworkError.encodingError
            }
        }
        
        //URL Request execution
        do {
            let (data, response) = try await session.data(for: request)
            
            //Logging response
            let isSuccess = 200...299 ~= (response as? HTTPURLResponse)?.statusCode ?? 0
            Logger.printResponse(data: data, response: response, error: nil, success: isSuccess)
            
            //Response validation
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.badRequest
            }
            
            //Status code validation
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 401:
                throw NetworkError.unauthorized
            case 404:
                throw NetworkError.notFound
            case 500...599:
                throw NetworkError.serverError
            default:
                throw NetworkError.httpError(statusCode: httpResponse.statusCode, message: "Unexpected error")
            }
            
            //Decoding data
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = config.keyDecodingStrategy
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
        } catch let error as URLError {
            if error.code == .notConnectedToInternet || error.code == .timedOut {
                throw NetworkError.connectionError
            }
            throw error
        }
    }
}
