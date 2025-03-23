//
//  RepoDetailsServiceTest.swift
//  GitHubAPI
//
//  Created by Petar  on 23.3.25..
//

import XCTest

final class RepoDetailsServiceTest: XCTestCase {
    
    //MARK: - Properties
    private var mockService: MockWebService!
    
    //MARK: - Lifecycle
    override func setUp() {
        super.setUp()
        setenv("ENV", "TEST", 1)
        mockService = NetworkServiceFactory.create() as? MockWebService
    }
    
    override func tearDown() {
        unsetenv("TEST")
        mockService = nil
        super.tearDown()
    }
    
    //MARK: - Testing methods
    func testFetchRepoDetailsSuccess() {
        let repoDetails = RepoDetails(name: "Repo1", forksCount: 100, watchersCount: 200)
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(repoDetails))
        mockService.setMockResponse(mockResponse)
        let repoDetailsService = RepoDetailsService(networkService: mockService)

        Task {
            do {
                let result = try await repoDetailsService.fetchRepoDetails(owner: "validValue", repoName: "validValue")
                
                XCTAssertEqual(result.name, "Repo1")
                XCTAssertEqual(result.forksCount, 100)
                XCTAssertEqual(result.watchersCount, 200)
            } catch {
                XCTFail("Test failed with error: \(error)")
            }
        }
    }
    
    func testFetchRepoDetailsApplicationError() {
        let mockResponse = MockResponse.applicationError(
            ApplicationError(message: "Invalid request", statusCode: 400))
        mockService.setMockResponse(mockResponse)
        let repoDetailsService = RepoDetailsService(networkService: mockService)

        Task {
            do {
                _ = try await repoDetailsService.fetchRepoDetails(owner: "invalidValue", repoName: "invalidValue")
                XCTFail("Expected error, but succeeded")
            } catch let error as ApplicationError {
                XCTAssertEqual(error.message, "Invalid request")
                XCTAssertEqual(error.statusCode, 400)
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    func testFetchRepoDetailsURLError() {
        let mockResponse = MockResponse.urlError(URLError(.notConnectedToInternet))
        mockService.setMockResponse(mockResponse)
        let repoDetailsService = RepoDetailsService(networkService: mockService)
        
        Task {
            do {
                _ = try await repoDetailsService.fetchRepoDetails(owner: "validValue", repoName: "validValue")
                XCTFail("Expected URLError, but succeeded")
            } catch let error as URLError {
                XCTAssertEqual(error.code, .notConnectedToInternet)
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    func testFetchRepoDetailsGenericError() {
        let mockResponse = MockResponse.otherError(NSError(domain: "CustomError", code: 999,
                                userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]))
        mockService.setMockResponse(mockResponse)
        let repoDetailsService = RepoDetailsService(networkService: mockService)
        
        Task {
            do {
                _ = try await repoDetailsService.fetchRepoDetails(owner: "validValue", repoName: "validValue")
                XCTFail("Expected generic error, but succeeded")
            } catch let error as NSError {
                XCTAssertEqual(error.domain, "CustomError")
                XCTAssertEqual(error.code, 999)
                XCTAssertEqual(error.localizedDescription, "Something went wrong")
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
}
