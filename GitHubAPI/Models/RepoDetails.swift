//
//  RepoDetails.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

struct RepoDetails: Codable {
    
    //MARK: - Properties
    let name: String
    let forksCount: Int
    let watchersCount: Int
}
