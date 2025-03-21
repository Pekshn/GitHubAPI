//
//  Logger.swift
//  GitHubAPI
//
//  Created by Petar  on 21.3.25..
//

import Foundation

class Logger {
    
    //MARK: - Request logger method
    static func printRequest(url: URL?, httpMethod: RequestMethod, headers: [String: String]?, params: [String: Any]?) {
        #if DEBUG
        let urlStr = url?.absoluteString.removingPercentEncoding ?? ""
        let httpMethodStr = httpMethod.rawValue
        print("🔼 Http request: \(urlStr) \(httpMethodStr)")
        
        if let headers = headers {
            print("Headers: \(headers.json() ?? "")")
        }
        if let params = params {
            print("Params: \(params.json() ?? "")")
        }
        #endif
    }
    
    //MARK: - Response logger method
    static func printResponse(data: Data?, response: URLResponse?, error: Error?, success: Bool) {
        #if DEBUG
        let symbol = success ? "✅" : "❌"
        
        //Success response
        if success {
            guard let httpResponse = response as? HTTPURLResponse else {
                print("\(symbol) Null httpResponse")
                return
            }
            print("\(symbol) Http response: \(httpResponse.url?.absoluteString.removingPercentEncoding ?? "")")
            print("Status code: \(httpResponse.statusCode)")
            
            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Body:")
                    print(jsonResponse)
                } catch let parsingError {
                    print("Error parsing response data: \(parsingError)")
                }
            } else {
                print("\(symbol) NO_RESPONSE")
            }
        } else { //Failed response
            if let error = error {
                print("\(symbol) Error: \(error.localizedDescription)")
            } else {
                print("\(symbol) Response failed but no error provided")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("\(symbol) Http response: \(httpResponse.url?.absoluteString.removingPercentEncoding ?? "")")
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Error body:")
                    print(jsonResponse)
                } catch let parsingError {
                    print("Error parsing response data: \(parsingError)")
                }
            }
        }
        #endif
    }
}
