//
//  RepoDetailsService.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class RepoDetailsService {
    
    //MARK: - Properties
    private let networkService: NetworkService
    
    //MARK: - Init
    init(networkService: NetworkService = NetworkServiceFactory.create()) {
        self.networkService = networkService
    }
    
    //MARK: - API Call
    func fetchRepoDetails(owner: String, repoName: String) async throws -> RepoDetails {
        guard let url = RequestEndpoint.repoDetails(owner: owner, repoName: repoName) else {
            throw ApplicationError(message: Localization.errorBadurl, statusCode: -1)
        }
        let config = RequestConfig(url: url)
        return try await networkService.makeRequest(config: config, responseType: RepoDetails.self)
    }
}
