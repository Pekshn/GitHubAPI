//
//  RepoListViewModel.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class RepoListViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published private(set) var repoItems: [RepoDetailsViewModel] = []
    @Published private(set) var errorMessage: String?
    private let repoListService: RepoListService
    
    //MARK: - Init
    init(repoListService: RepoListService = RepoListService()) {
        self.repoListService = repoListService
    }
}

//MARK: - Public API
extension RepoListViewModel {
    
    //Fetch User Repos
    func fetchUserRepos(username: String) async {
        do {
            let repos = try await repoListService.fetchUserRepos(username: username)
            self.repoItems = repos.map { RepoDetailsViewModel(repo: $0) }
        } catch {
            //TODO: - Refactor this later
            self.errorMessage = "Failed to load repos"
        }
    }
}
