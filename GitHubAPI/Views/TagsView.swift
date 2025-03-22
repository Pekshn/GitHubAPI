//
//  TagsView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct TagsView: View {
    
    //MARK: - Properties
    @ObservedObject var viewModel: RepoDetailsViewModel
    
    //MARK: - Body
    var body: some View {
        if viewModel.tags.isEmpty {
            //Placeholder & Loading
            TagsPlaceholderView(tagsLoading: $viewModel.tagsLoading)
                .padding(.vertical, 50)
        } else  {
            //Items
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.tags) { tag in
                    TagItemView(tag: tag)
                } //: ForEach
            } //: LazyVStack
            .padding(.bottom, 10)
        }
    }
}

//MARK: - Preview
#Preview {
    TagsView(viewModel: RepoDetailsViewModel(repo: Repo(id: 64778136, name: "linguist", openIssuesCount: 21, owner: Owner(name: "octocat"), avatarUrl: "https://avatars.githubusercontent.com/u/583231?v=4")))
}
