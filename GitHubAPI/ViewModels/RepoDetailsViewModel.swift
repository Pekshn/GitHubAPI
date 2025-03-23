//
//  RepoDetailsViewModel.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class RepoDetailsViewModel: ObservableObject, Identifiable {
    
    //MARK: - Properties
    @Published var forksCount: String = " "
    @Published var watchersCount: String = " "
    @Published private(set) var tags: [Tag] = []
    @Published var tagsLoading: Bool = false
    @Published var error: ApplicationError?
    private let repoDetailsService: RepoDetailsService
    private let repoTagsService: RepoTagsService
    private let repo: Repo
    
    //Computed
    var id: Int { repo.id }
    var repoName: String { repo.name }
    var openIssuesCount: String { "\(repo.openIssuesCount)" }
    var username: String { repo.owner.name }
    var avatarString: String? { repo.owner.avatarUrl }
    
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
    @MainActor
    func fetchDetails() async {
        do {
            let details = try await repoDetailsService.fetchRepoDetails(owner: repo.owner.name, repoName: repo.name)
            self.forksCount = "\(details.forksCount)"
            self.watchersCount = "\(details.watchersCount)"
        } catch {
            self.error = ApplicationError.from(error: error)
        }
    }
    
    //Fetch Tags
    @MainActor
    func fetchTags() async {
        self.tagsLoading = true
        do {
            let tags = try await repoTagsService.fetchRepoTags(owner: repo.owner.name, repoName: repo.name)
            self.tags = tags
        } catch {
            self.error = ApplicationError.from(error: error)
        }
        self.tagsLoading = false
    }
}
