//
//  Localization.swift
//  GitHubAPI
//
//  Created by Petar  on 23.3.25..
//

import Foundation

struct Localization {
    
    //MARK: - Properties
    static var error: String { Localizator.get("Error.Error") }
    static var errorBadurl: String { Localizator.get("Error.Bad Url") }
    static var errorBarRequest: String { Localizator.get("Error.Bad Request") }
    static var errorEncoding: String { Localizator.get("Error.Encoding") }
    static var errorDecoding: String { Localizator.get("Error.Decoding") }
    static var errorUnauthorized: String { Localizator.get("Error.Unauthorized") }
    static var errorNotFound: String { Localizator.get("Error.Not found") }
    static var errorServer: String { Localizator.get("Error.Server") }
    static var errorConnection: String { Localizator.get("Error.Connection") }
    static var errorUnexpected: String { Localizator.get("Error.Unexpected") }
    
    static var ok: String { Localizator.get("OK") }
    static var reposOfX: String { Localizator.get("Repos of x") }
    static var reposCountX: String { Localizator.get("Repos count: x") }
    static var copyrightPetar: String { Localizator.get("Copyright Petar") }
    static var forks: String { Localizator.get("Forks:") }
    static var watchers: String { Localizator.get("Watchers:") }
    static var noReposFound: String { Localizator.get("No repos found") }
    static var openIssuesCountX: String { Localizator.get("Open issues count: x") }
    static var repo: String { Localizator.get("Repo:") }
    static var commitX: String { Localizator.get("Commit: x") }
    static var loadingTags: String { Localizator.get("Loading tags") }
    static var noTags: String { Localizator.get("No tags") }
    static var tags: String { Localizator.get("Tags:") }
}

final private class Localizator {
    
    static func get(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
