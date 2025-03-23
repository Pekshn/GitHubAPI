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
    @Environment(\.colorScheme) private var colorScheme
    
    //Computed
    var headerBgColor: Color {
        let light = Color(.lightGray)
        let dark = Color(UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0))
        return colorScheme == .light ? light : dark
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            headerBgColor
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack() {
                        //Repo name
                        RepoNameView(repoName: viewModel.repoName)
                        
                        //Avatar image
                        AvatarView(avatarUrl: viewModel.avatarString ?? "", bgColor: headerBgColor)
                            .zIndex(1)
                        
                        VStack {
                            //Username
                            Text(viewModel.username)
                                .font(.system(.title, weight: .heavy))
                                .fontWeight(.bold)
                                .padding(.top, 20)
                                .padding(.bottom, 10)
                            
                            Color(.lightGray).opacity(0.5)
                                .frame(height: 1)
                                .padding(.vertical)
                            
                            //Forks and Watchers
                            ForksAndWatchersView(viewModel: viewModel)
                            
                            //Tags title
                            TagsTitleView()
                            
                            //Tag items
                            TagsView(viewModel: viewModel)
                        } //: VStack
                        .background(Color(.systemBackground))
                        .background(
                            Color(.systemBackground)
                                .clipShape(CustomShape())
                                .padding(.top, -90)
                        )
                        .zIndex(0)
                    } //: VStack
                } //: ScrollView
                
                //Copyright footer
                CopyrightView(bgColor: headerBgColor)
            } //: VStack
        } //: ZStack
        .task {
            await viewModel.fetchDetails()
            await viewModel.fetchTags()
        } //: task
        .alert(item: $viewModel.error) { error in
            Alert(title: Text(Localization.error), message: Text("\(error.message)"), dismissButton: .default(Text(Localization.ok)))
        } //: alert
    }
}

//MARK: - Preview
#Preview {
    NavigationStack {
        RepoDetailsView(viewModel: RepoDetailsViewModel(repo: Repo(id: 64778136, name: "linguist", openIssuesCount: 21, owner: Owner(name: "octocat", avatarUrl: "https://avatars.githubusercontent.com/u/583231?v=4"))))
    }
}
