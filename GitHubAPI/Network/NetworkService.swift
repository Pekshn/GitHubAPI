//
//  NetworkService.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

//MARK: - NetworkService protocol
protocol NetworkService {
    func makeRequest<T: Decodable>(config: RequestConfig, responseType: T.Type) async throws -> T
}
