//
//  Repo.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

struct Repo: Codable, Identifiable {
    
    //MARK: - Properties
    let id: Int
    let name: String
    let openIssuesCount: Int
}
