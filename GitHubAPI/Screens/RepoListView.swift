//
//  RepoListView.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import SwiftUI

struct RepoListView: View {
    
    //MARK: - Properties
    @StateObject private var viewModel = RepoListViewModel()
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            List(viewModel.repoItems) { repoVM in
                NavigationLink(destination: RepoDetailsView(viewModel: repoVM)) {
                    VStack(alignment: .leading) {
                        Text(repoVM.repo.name)
                            .font(.headline)
                    }
                }
                .padding()
            }
            .task {
                await viewModel.fetchUserRepos(username: "octocat")
            }
            .navigationTitle("Repo items")
        }
    }
}

//MARK: - Preview
#Preview {
    RepoListView()
}
