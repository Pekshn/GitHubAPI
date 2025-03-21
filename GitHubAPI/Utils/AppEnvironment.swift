//
//  AppEnvironment.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class AppEnvironment {
    
    static let shared = AppEnvironment()
    let config: [String:String]
    
    //MARK: - Properties
    var serverUrl: String { config[Constants.serverBaseUrl] ?? "" }
    
    //MARK: - Init
    private init() {
        config = Bundle.main.object(forInfoDictionaryKey: Constants.config) as? [String : String] ?? [:]
    }
}
