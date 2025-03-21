//
//  Tag.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

struct Tag: Codable {
    
    //MARK: - Properties
    let name: String
    let commit: Commit
}
