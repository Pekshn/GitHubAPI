//
//  Tag.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

struct Tag: Codable, Identifiable {
    
    //MARK: - Properties
    var id: String { "\(name)-\(commit.sha)" }
    let name: String
    let commit: Commit
}
