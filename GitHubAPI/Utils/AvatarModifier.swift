//
//  AvatarModifier.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct AvatarModifier: ViewModifier {
    
    //MARK: - Properties
    let bgColor: Color
    
    //MARK: - Body
    func body(content: Content) -> some View {
        return content
            .scaledToFit()
            .frame(width: 150, height: 150, alignment: .center)
            .foregroundColor(.gray.opacity(0.6))
            .cornerRadius(75)
            .background(
                Circle()
                    .fill(bgColor)
                    .frame(width: 160, height: 160, alignment: .center)
            )
            .background(
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: 170, height: 170, alignment: .center)
            )
            .background(
                Circle()
                    .fill(bgColor)
                    .frame(width: 180, height: 180, alignment: .center)
            )
    }
}
