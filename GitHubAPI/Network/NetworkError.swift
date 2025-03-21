//
//  NetworkError.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

//MARK: - Custom Network Error
enum NetworkError: Error {
    case badURL
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case decodingError
    case encodingError
    case connectionError
    case httpError(statusCode: Int, message: String)
}
