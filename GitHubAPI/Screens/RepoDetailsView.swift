//
//  RepoDetailsView.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import SwiftUI

struct RepoDetailsView: View {
    
    //MARK: - Properties
    @StateObject var viewModel: RepoDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let repoDetails = viewModel.repoDetails {
                    Text("name: \(repoDetails.name)")
                        .font(.largeTitle)
                    Text("forksCount: \(repoDetails.forksCount)")
                    Text("watchersCount: \(repoDetails.watchersCount)")
                } else {
                    Text("Details Loading...")
                        .onAppear {
                            Task {
                                await viewModel.fetchDetails()
                                await viewModel.fetchTags()
                            }
                        }
                }
                Text("Tags:")
                ForEach(viewModel.tags, id: \.id) { tag in
                    Text("Tag Name: \(tag.name)")
                    Text("Tag Commit: \(tag.commit.sha)")
                }
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"), message: Text("\(error.message)"), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    RepoDetailsView(viewModel: RepoDetailsViewModel(repo: Repo(id: 64778136, name: "linguist", openIssuesCount: 21, owner: Owner(name: "octocat"), avatarUrl: "https://avatars.githubusercontent.com/u/583231?v=4")))
}
