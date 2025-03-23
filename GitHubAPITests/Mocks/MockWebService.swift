//
//  MockWebService.swift
//  GitHubAPI
//
//  Created by Petar  on 23.3.25..
//

import Foundation

enum MockResponse {
    case success(Data)
    case applicationError(ApplicationError)
    case urlError(URLError)
    case otherError(Error)
}

class MockWebService: NetworkService {
    
    //MARK: - Properties
    var mockResponse: MockResponse?
    
    //MARK: - Init
    init() {
        
    }
    
    //MARK: - Set MockWebService response
    func setMockResponse(_ response: MockResponse) {
        self.mockResponse = response
    }
    
    //MARK: - NetworkService protocol method
    func makeRequest<T: Decodable>(config: RequestConfig, responseType: T.Type) async throws -> T {
        guard let response = mockResponse else {
            throw ApplicationError(message: "No mock response set", statusCode: -1)
        }
        
        switch response {
        case .success(let data):
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw ApplicationError(message: "Decoding error", statusCode: -1)
            }
        case .applicationError(let error):
            throw error
        case .urlError(let error):
            throw error
        case .otherError(let error):
            throw error
        }
    }
}
