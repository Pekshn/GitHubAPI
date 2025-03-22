//
//  AvatarView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct AvatarView: View {
    
    //MARK: - Properties
    @State var avatarUrl: String
    let bgColor: Color
    
    //MARK: - Body
    var body: some View {
        AsyncImage(url: URL(string: avatarUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .modifier(AvatarModifier(bgColor: bgColor))
            default:
                Image(systemName: "person.circle")
                    .resizable()
                    .modifier(AvatarModifier(bgColor: bgColor))
            } //: switch
        } //: AsyncImage
    }
}

//MARK: - Preview
#Preview {
    AvatarView(avatarUrl: "https://avatars.githubusercontent.com/u/583231?v=4", bgColor: .gray)
}
