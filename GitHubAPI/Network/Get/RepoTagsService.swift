//
//  RepoTagsService.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class RepoTagsService {
    
    //MARK: - Properties
    private let networkService: NetworkService
    
    //MARK: - Init
    init(networkService: NetworkService = Webservice.shared) {
        self.networkService = networkService
    }
    
    //MARK: - API Call
    func fetchRepoTags(owner: String, repoName: String) async throws -> [Tag] {
        guard let url = RequestEndpoint.repoTags(owner: owner, repoName: repoName) else {
            throw ApplicationError(message: Localization.errorBadurl, statusCode: -1)
        }
        let config = RequestConfig(url: url)
        return try await networkService.makeRequest(config: config, responseType: [Tag].self)
    }
}
