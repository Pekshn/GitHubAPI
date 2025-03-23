//
//  NetworkServiceFactory.swift
//  GitHubAPI
//
//  Created by Petar  on 23.3.25..
//

import Foundation

class NetworkServiceFactory {
    
    //MARK: - Create NetworkService
    static func create() -> NetworkService {
        let env = ProcessInfo.processInfo.environment["ENV"]
        if let env = env {
            if env == "TEST" {
                return MockWebService()
            } else {
                return WebService.shared
            }
        }
        return WebService.shared
    }
}
