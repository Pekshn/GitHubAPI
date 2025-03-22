//
//  RepoItemView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct RepoItemView: View {
    
    //MARK: - Properties
    @ObservedObject var repoVM: RepoDetailsViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    //Computed
    var borderColor: Color { colorScheme == .dark ? .white : .gray }
    var borderOpacity: Double { colorScheme == .dark ? 0.3 : 0.1 }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            //Shadow only in light mode
            if colorScheme == .light {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 4, y: 4)
            }
            
            //Content
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "folder.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.cyan)
                        .frame(width: 20, height: 20, alignment: .center)
                    
                    Text(repoVM.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.label))
                    
                    Spacer()
                } //: HStack
                
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.red)
                        .frame(width: 20, height: 20, alignment: .center)
                    
                    Text("Open issues count: \(repoVM.issuesCount)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                } //: HStack
            } //: VStack
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor.opacity(borderOpacity), lineWidth: 2)
            ) //: overlay
            .frame(maxWidth: .infinity)
        } //: ZStack
        .padding(.vertical, 2)
        .padding(.horizontal, 15)
    }
}

//MARK: - Preview
struct RepoItemView_Previews: PreviewProvider {
    static var previews: some View {
        let repo = Repo(id: 132935648, name: "boysenberry-repo-1", openIssuesCount: 112, owner: Owner(name: "octocat"))
        RepoItemView(repoVM: RepoDetailsViewModel(repo: repo))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
