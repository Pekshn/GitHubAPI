//
//  RepoDetailsViewModel.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class RepoDetailsViewModel: ObservableObject, Identifiable {
    
    //MARK: - Properties
    @Published private(set) var repoDetails: RepoDetails?
    @Published private(set) var tags: [Tag] = []
    @Published private(set) var errorMessage: String?
    private let repoDetailsService: RepoDetailsService
    private let repoTagsService: RepoTagsService
    private(set) var repo: Repo
    var id: Int { repo.id }
    
    //MARK: - Init
    init(repo: Repo, repoDetailsService: RepoDetailsService = RepoDetailsService(), repoTagsService: RepoTagsService = RepoTagsService()) {
        self.repo = repo
        self.repoDetailsService = repoDetailsService
        self.repoTagsService = repoTagsService
    }
}

//MARK: - Public API
extension RepoDetailsViewModel {
    
    //Fetch Details
    func fetchDetails() async {
        do {
            let details = try await repoDetailsService.fetchRepoDetails(owner: repo.owner.name, repoName: repo.name)
            self.repoDetails = details
        } catch {
            //TODO: - Refactor this later
            self.errorMessage = "Failed to load repo details"
        }
    }
    
    //Fetch Tags
    func fetchTags() async {
        do {
            let tags = try await repoTagsService.fetchRepoTags(owner: repo.owner.name, repoName: repo.name)
            self.tags = tags
        } catch {
            //TODO: - Refactor this later
            self.errorMessage = "Failed to load repo tags"
        }
    }
}
