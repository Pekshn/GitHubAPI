//
//  RepoTagsServiceTest.swift
//  GitHubAPI
//
//  Created by Petar  on 23.3.25..
//

import XCTest

final class RepoTagsServiceTest: XCTestCase {

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
    func testFetchRepoTagsSuccess() {
        let testTags = [
            Tag(name: "Tag1", commit: Commit(sha: "sha1")),
            Tag(name: "Tag2", commit: Commit(sha: "sha2"))
        ]
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(testTags))

        mockService.setMockResponse(mockResponse)
        let repoTagsService = RepoTagsService(networkService: mockService)

        Task {
            do {
                let result = try await repoTagsService.fetchRepoTags(owner: "validValue", repoName: "validValue")
                
                XCTAssertEqual(result.count, 2)
                XCTAssertEqual(result.first?.name, "Tag1")
                XCTAssertEqual(result.first?.commit.sha, "sha1")
            } catch {
                XCTFail("Test failed with error: \(error)")
            }
        }
    }
    
    func testFetchRepoTagsApplicationError() {
        let mockResponse = MockResponse.applicationError(
            ApplicationError(message: "Invalid request", statusCode: 400))
        
        mockService.setMockResponse(mockResponse)
        let repoTagsService = RepoTagsService(networkService: mockService)

        Task {
            do {
                _ = try await repoTagsService.fetchRepoTags(owner: "invalidValue", repoName: "invalidValue")
                XCTFail("Expected error, but succeeded")
            } catch let error as ApplicationError {
                XCTAssertEqual(error.message, "Invalid request")
                XCTAssertEqual(error.statusCode, 400)
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    func testFetchRepoTagsURLError() {
        let mockResponse = MockResponse.urlError(URLError(.notConnectedToInternet))
        
        mockService.setMockResponse(mockResponse)
        let repoTagsService = RepoTagsService(networkService: mockService)
        
        Task {
            do {
                _ = try await repoTagsService.fetchRepoTags(owner: "validValue", repoName: "validValue")
                XCTFail("Expected URLError, but succeeded")
            } catch let error as URLError {
                XCTAssertEqual(error.code, .notConnectedToInternet)
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
    }
    
    func testFetchRepoTagsGenericError() {
        let mockResponse = MockResponse.otherError(NSError(domain: "CustomError", code: 999,
                                userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]))
        
        mockService.setMockResponse(mockResponse)
        let repoTagsService = RepoTagsService(networkService: mockService)
        
        Task {
            do {
                _ = try await repoTagsService.fetchRepoTags(owner: "validValue", repoName: "validValue")
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
