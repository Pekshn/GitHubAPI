//
//  CopyrightView.swift
//  GitHubAPI
//
//  Created by Petar  on 22.3.25..
//

import SwiftUI

struct CopyrightView: View {
    
    //MARK: - Properties
    let bgColor: Color
    
    //MARK: - Body
    var body: some View {
        Text("Copyright ©  Petar Novakovic \nAll right reserved")
            .font(.system(.footnote, weight: .bold))
            .multilineTextAlignment(.center)
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
            .background(bgColor)
    }
}

//MARK: - Preview
#Preview {
    CopyrightView(bgColor: Color.gray)
}
