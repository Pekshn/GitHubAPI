//
//  RepoNameView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct RepoNameView: View {
    
    //MARK: - Properties
    @State var repoName: String
    
    //MARK: - Body
    var body: some View {
        VStack {
            Text(Localization.repo)
                .padding(.top, 10)
            
            Text(repoName)
                .font(.system(.largeTitle, weight: .heavy))
                .fontWeight(.bold)
                .padding(.bottom, 40)
        } //: VStack
    }
}

//MARK: - Preview
struct RepoNameView_Previews: PreviewProvider {
    static var previews: some View {
        RepoNameView(repoName: "RepoNameView")
            .previewLayout(.sizeThatFits)
    }
}
