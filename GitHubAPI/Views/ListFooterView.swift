//
//  ListFooterView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct ListFooterView: View {
    
    //MARK: - Properties
    @ObservedObject var viewModel: RepoListViewModel
    
    //MARK: - Body
    var body: some View {
        VStack() {
            Color.primary
                .frame(height: 1)
                .padding(.horizontal, 7)
            
            HStack(alignment: .top, spacing: 0) {
                Spacer()
                
                Text(viewModel.reposCount)
                    .padding(.top, 10)
                
                Spacer()
            } //: HStack
        } //: VStack
        .padding(.top, 0)
    }
}

//MARK: - Preview
struct ListFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ListFooterView(viewModel: RepoListViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
