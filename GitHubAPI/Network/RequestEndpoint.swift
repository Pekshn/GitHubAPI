//
//  Untitled.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

struct RequestEndpoint {
    
    //MARK: - Base
    private static var baseURL: String { AppEnvironment.shared.serverUrl }
    
    //MARK: - Endpoints
    static func repoList(username: String) -> URL? {
        return URL(string: "\(baseURL)/users/\(username)/repos")
    }
}
