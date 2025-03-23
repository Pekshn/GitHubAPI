//
//  ForksAndWatchersView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct ForksAndWatchersView: View {
    
    //MARK: - Properties
    @ObservedObject var viewModel: RepoDetailsViewModel
    
    //MARK: - Body
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 5) {
                Text(Localization.forks)
                Text(viewModel.forksCount)
            } //: VStack
            .padding(.horizontal, 30)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 5) {
                Text(Localization.watchers)
                Text(viewModel.watchersCount)
            } //: VStack
            .padding(.horizontal, 30)
        } //: HStack
        .font(.system(.title2, weight: .medium))
        .padding(.vertical, 5)
    }
}

//MARK: - Preview
#Preview {
    ForksAndWatchersView(viewModel: RepoDetailsViewModel(repo: Repo(id: 64778136, name: "linguist", openIssuesCount: 21, owner: Owner(name: "octocat", avatarUrl: "https://avatars.githubusercontent.com/u/583231?v=4"))))
}
