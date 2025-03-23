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
    @Published var error: ApplicationError?
    @Published var isLoading: Bool = false
    @Published var reposCount: String = ""
    private let repoListService: RepoListService
    
    //MARK: - Init
    init(repoListService: RepoListService = RepoListService()) {
        self.repoListService = repoListService
    }
}

//MARK: - Public API
extension RepoListViewModel {
    
    //Fetch User Repos
    @MainActor
    func fetchUserRepos(username: String) async {
        self.isLoading = true
        do {
            let repos = try await repoListService.fetchUserRepos(username: username)
            self.repoItems = repos.map { RepoDetailsViewModel(repo: $0) }
            self.reposCount = String(format: Localization.reposCountX, repos.count)
        } catch {
            self.error = ApplicationError.from(error: error)
        }
        self.isLoading = false
    }
}
