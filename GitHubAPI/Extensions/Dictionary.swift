//
//  Dictionary.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

extension Dictionary {
    
    //MARK: - JSON to String?
    func json() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
