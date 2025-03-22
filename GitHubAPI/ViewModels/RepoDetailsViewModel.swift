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
    @Published var error: ApplicationError?
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
            await MainActor.run {
                self.repoDetails = details
            }
        } catch let error as ApplicationError {
            await MainActor.run {
                self.error = error
            }
        } catch {
            await MainActor.run {
                self.error = ApplicationError(message: "\(error.localizedDescription)", statusCode: -1)
            }
        }
    }
    
    //Fetch Tags
    func fetchTags() async {
        do {
            let tags = try await repoTagsService.fetchRepoTags(owner: repo.owner.name, repoName: repo.name)
            await MainActor.run {
                self.tags = tags
            }
        } catch let error as ApplicationError {
            await MainActor.run {
                self.error = error
            }
        } catch {
            await MainActor.run {
                self.error = ApplicationError(message: "\(error.localizedDescription)", statusCode: -1)
            }
        }
    }
}
