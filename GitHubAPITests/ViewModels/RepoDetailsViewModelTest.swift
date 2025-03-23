//
//  RepoDetailsViewModelTest.swift
//  GitHubAPI
//
//  Created by Petar  on 23.3.25..
//

import XCTest

class RepoDetailsViewModelTest: XCTestCase {
    
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
    func testFetchDetailsSuccess() {
        let testRepo = Repo(id: 1, name: "Repo1", openIssuesCount: 5, owner: Owner(name: "owner1", avatarUrl: nil))
        let testDetails = RepoDetails(name: "Repo1", forksCount: 10, watchersCount: 15)
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(testDetails))
        mockService.setMockResponse(mockResponse)
        
        let repoDetailsService = RepoDetailsService(networkService: mockService)
        let viewModel = RepoDetailsViewModel(repo: testRepo, repoDetailsService: repoDetailsService)
        
        Task {
            await viewModel.fetchDetails()
            
            XCTAssertEqual(viewModel.forksCount, "10")
            XCTAssertEqual(viewModel.watchersCount, "15")
        }
    }
    
    func testFetchDetailsError() {
        let testRepo = Repo(id: 1, name: "Repo1", openIssuesCount: 5, owner: Owner(name: "owner1", avatarUrl: nil))
        let mockResponse = MockResponse.applicationError(ApplicationError(
            message: "Invalid request", statusCode: 400))
        mockService.setMockResponse(mockResponse)
        
        let repoDetailsService = RepoDetailsService(networkService: mockService)
        let viewModel = RepoDetailsViewModel(repo: testRepo, repoDetailsService: repoDetailsService)

        Task {
            await viewModel.fetchDetails()
            
            XCTAssertNotNil(viewModel.error)
            XCTAssertEqual(viewModel.error?.message, "Invalid request")
            XCTAssertEqual(viewModel.error?.statusCode, 400)
        }
    }
    
    func testFetchTagsSuccess() {
        let testRepo = Repo(id: 1, name: "Repo1", openIssuesCount: 5, owner: Owner(name: "owner1", avatarUrl: nil))
        let testTags = [Tag(name: "Tag1", commit: Commit(sha: "sha1")), Tag(name: "Tag2", commit: Commit(sha: "sha2"))]
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(testTags))
        mockService.setMockResponse(mockResponse)
        
        let repoTagsService = RepoTagsService(networkService: mockService)
        let viewModel = RepoDetailsViewModel(repo: testRepo, repoTagsService: repoTagsService)
        
        Task {
            await viewModel.fetchTags()
            
            XCTAssertEqual(viewModel.tags.count, 2)
            XCTAssertEqual(viewModel.tags.first?.name, "Tag1")
        }
    }
    
    func testIsTagsLoadingState() {
        let testRepo = Repo(id: 1, name: "Repo1", openIssuesCount: 5, owner: Owner(name: "owner1", avatarUrl: nil))
        let testTags: [Tag] = []
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(testTags))
        mockService.setMockResponse(mockResponse)
        
        let repoTagsService = RepoTagsService(networkService: mockService)
        let viewModel = RepoDetailsViewModel(repo: testRepo, repoTagsService: repoTagsService)
        
        XCTAssertFalse(viewModel.tagsLoading)
        Task {
            await viewModel.fetchTags()
            XCTAssertFalse(viewModel.tagsLoading)
        }
    }
    
    func testFetchTagsError() {
        let testRepo = Repo(id: 1, name: "Repo1", openIssuesCount: 5, owner: Owner(name: "owner1", avatarUrl: nil))
        let mockResponse = MockResponse.applicationError(ApplicationError(
            message: "Tags fetching failed", statusCode: 500))
        mockService.setMockResponse(mockResponse)
        
        let repoTagsService = RepoTagsService(networkService: mockService)
        let viewModel = RepoDetailsViewModel(repo: testRepo, repoTagsService: repoTagsService)
        
        Task {
            await viewModel.fetchTags()
            
            XCTAssertNotNil(viewModel.error)
            XCTAssertEqual(viewModel.error?.message, "Tags fetching failed")
            XCTAssertEqual(viewModel.error?.statusCode, 500)
        }
    }
}
