//
//  TagsTitleView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct TagsTitleView: View {
    
    //MARK: - Body
    var body: some View {
        HStack {
            Color(.lightGray).opacity(0.5)
                .frame(height: 1)
                .padding(.vertical)
            
            Text(Localization.tags)
                .font(.system(.title, weight: .bold))
                .padding(.vertical, 10)
                .padding(.horizontal)
            
            Color(.lightGray).opacity(0.5)
                .frame(height: 1)
                .padding(.vertical)
        } //: HStack
    }
}

//MARK: - Preview
#Preview {
    TagsTitleView()
}
