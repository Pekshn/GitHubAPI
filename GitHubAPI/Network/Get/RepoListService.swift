//
//  RepoListService.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class RepoListService {
    
    //MARK: - Properties
    private let networkService: NetworkService
    
    //MARK: - Init
    init(networkService: NetworkService = Webservice.shared) {
        self.networkService = networkService
    }
    
    //MARK: - API Call
    func fetchUserRepos(username: String) async throws -> [Repo] {
        guard let url = RequestEndpoint.repoList(username: username) else {
            throw ApplicationError(message: Localization.errorBadurl, statusCode: -1)
        }
        let config = RequestConfig(url: url)
        return try await networkService.makeRequest(config: config, responseType: [Repo].self)
    }
}
