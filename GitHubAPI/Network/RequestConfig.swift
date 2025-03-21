//
//  RequestConfig.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

struct RequestConfig {
    
    //MARK: - Properties
    let url: URL
    let httpMethod: RequestMethod
    let httpHeaders: [String: String]?
    let httpParams: [String: Any]?
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    
    //MARK: - Init
    init(url: URL,
         httpMethod: RequestMethod = .get,
         httpHeaders: [String: String]? = nil,
         params: [String: Any]? = nil,
         keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
        self.url = url
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
        self.httpParams = params
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}
