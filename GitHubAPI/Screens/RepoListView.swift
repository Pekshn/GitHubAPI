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
    @State private var username = Constants.defaultUsername
    @Environment(\.colorScheme) private var colorScheme
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.clear, in: RoundedRectangle(cornerRadius: 10))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        if viewModel.repoItems.isEmpty {
                            //Placeholder view
                            PlaceholderView()
                        } else {
                            //List view
                            ScrollView(showsIndicators: false) {
                                LazyVStack(alignment: .leading) {
                                    ForEach(viewModel.repoItems) { repoVM in
                                        NavigationLink(destination: RepoDetailsView(viewModel: repoVM)) {
                                            RepoItemView(repoVM: repoVM)
                                        } //: NavigationLink
                                    } //: ForEach
                                } //: LazyVStack
                                .padding(.bottom, 10)
                            } //: ScrollView
                            
                            //Footer view
                            ListFooterView(viewModel: viewModel)
                        }
                    } //: VStack
                }
            } //: ZStack
            .task {
                await viewModel.fetchUserRepos(username: username)
            } //: task
            .navigationTitle("Repos of \(username)")
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"), message: Text("\(error.message)"), dismissButton: .default(Text("OK")))
            }
        } //: NavigationStack
        .tint(colorScheme == .dark ? .white : .black)
        .accentColor(colorScheme == .dark ? .white : .black) //iOS 16.0
    }
}

//MARK: - Preview
#Preview {
    RepoListView()
}
