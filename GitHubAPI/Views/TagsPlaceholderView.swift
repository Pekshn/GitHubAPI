//
//  TagsPlaceholderView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct TagsPlaceholderView: View {
    
    //MARK: - Properties
    @Binding var tagsLoading: Bool
    
    //MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: tagsLoading ? "gearshape.arrow.triangle.2.circlepath" : "tag.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray.opacity(0.6))
            
            Text(tagsLoading ? "Loading tags..." : "No tags found.")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.top, 20)
        } //: VStack
        .background(Color.clear)
    }
}

//MARK: - Preview
#Preview {
    TagsPlaceholderView(tagsLoading: .constant(false))
}
