//
//  TagItemView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct TagItemView: View {
    
    //MARK: - Properties
    private(set) var tag: Tag
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "tag")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.cyan)
                    .frame(width: 20, height: 20, alignment: .center)
                
                Text(tag.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            } //: HStack
            .padding(.horizontal)
            .padding(.top, 5)
            
            HStack {
                Text("Commit: \(tag.commit.sha)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Spacer()
            } //: HStack
            .padding(.horizontal)
            
            Color(.lightGray)
                .frame(height: 1)
                .padding(.horizontal, 10)
        } //: VStack
    }
}

//MARK: - Preview
struct TagItemView_Previews: PreviewProvider {
    static var previews: some View {
        TagItemView(tag: Tag(name: "name", commit: Commit(sha: "sha")))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
