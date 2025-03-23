//
//  PlaceholderView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct PlaceholderView: View {
    
    //MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: "waveform.badge.magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
            
            Text(Localization.noReposFound)
                .font(.title3)
                .foregroundColor(.gray)
        } //: VStack
        .background(Color.clear)
    }
}

//MARK: - Preview
#Preview {
    PlaceholderView()
}
