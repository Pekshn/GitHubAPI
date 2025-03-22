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
                throw ApplicationError(message: ErrorMessage.encodingError, statusCode: -1)
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
                throw ApplicationError(message: ErrorMessage.badRequest, statusCode: -1)
            }
            
            //Status code validation
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 400...499:
                throw handleAPIErrorResponse(data: data, httpResponse: httpResponse, statusCode: httpResponse.statusCode)
            case 500...599:
                throw handleAPIErrorResponse(data: data, httpResponse: httpResponse, statusCode: httpResponse.statusCode)
            default:
                throw ApplicationError(message: ErrorMessage.unexpectedError, statusCode: httpResponse.statusCode)
            }
            
            //Decoding data
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = config.keyDecodingStrategy
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw ApplicationError(message: ErrorMessage.decodingError, statusCode: -1)
            }
        } catch let error as URLError {
            if error.code == .notConnectedToInternet || error.code == .timedOut {
                throw ApplicationError(message: ErrorMessage.connectionError, statusCode: -1)
            }
            throw error
        }
    }
}

//MARK: - Private API
extension Webservice {
    
    private func handleAPIErrorResponse(data: Data, httpResponse: HTTPURLResponse, statusCode: Int) -> ApplicationError {
        do {
            let errorResponse = try JSONDecoder().decode(GitHubError.self, from: data)
            return ApplicationError(message: errorResponse.message, statusCode: statusCode)
        } catch {
            if statusCode == 401 {
                return ApplicationError(message: ErrorMessage.unauthorized, statusCode: statusCode)
            } else if statusCode == 404 {
                return ApplicationError(message: ErrorMessage.notFound, statusCode: statusCode)
            }
            return ApplicationError(message: ErrorMessage.serverError, statusCode: statusCode)
        }
    }
}
