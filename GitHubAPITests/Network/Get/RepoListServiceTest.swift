//
//  RepoListServiceTest.swift
//  GitHubAPITests
//
//  Created by Petar  on 23.3.25..
//

import XCTest

final class RepoListServiceTest: XCTestCase {
    
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
    func testFetchUserReposSuccess() {
        let testRepos = [
            Repo(id: 1, name: "Repo1", openIssuesCount: 5, owner: Owner(name: "owner1", avatarUrl: nil)),
            Repo(id: 2, name: "Repo2", openIssuesCount: 3, owner: Owner(name: "owner2", avatarUrl: nil))
        ]
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(testRepos))
        
        mockService.setMockResponse(mockResponse)
        let repoListService = RepoListService(networkService: mockService)
        
        Task {
            do {
                let result = try await repoListService.fetchUserRepos(username: "validUsername")
                
                XCTAssertEqual(result.count, 2)
                XCTAssertEqual(result.first?.name, "Repo1")
            } catch {
                XCTFail("Test failed with error: \(error)")
            }
        }
    }
    
    func testFetchUserReposApplicationError() {
        let mockResponse = MockResponse.applicationError(
            ApplicationError(message: "Invalid request", statusCode: 400))
        
        mockService.setMockResponse(mockResponse)
        let repoListService = RepoListService(networkService: mockService)
        
        Task {
            do {
                _ = try await repoListService.fetchUserRepos(username: "invalidUsername")
                XCTFail("Expected error, but succeeded")
            } catch let error as ApplicationError {
                XCTAssertEqual(error.message, "Invalid request")
                XCTAssertEqual(error.statusCode, 400)
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    func testFetchUserReposURLError() {
        let mockResponse = MockResponse.urlError(URLError(.notConnectedToInternet))
        
        mockService.setMockResponse(mockResponse)
        let repoListService = RepoListService(networkService: mockService)
        
        Task {
            do {
                _ = try await repoListService.fetchUserRepos(username: "validUsername")
                XCTFail("Expected URLError, but succeeded")
            } catch let error as URLError {
                XCTAssertEqual(error.code, .notConnectedToInternet)
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    func testFetchUserReposGenericError() {
        let mockResponse = MockResponse.otherError(NSError(domain: "CustomError", code: 999,
                                userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]))
        
        mockService.setMockResponse(mockResponse)
        let repoListService = RepoListService(networkService: mockService)
        
        Task {
            do {
                _ = try await repoListService.fetchUserRepos(username: "validUsername")
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
