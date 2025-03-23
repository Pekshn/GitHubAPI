//
//  RepoListViewModelTest.swift
//  GitHubAPI
//
//  Created by Petar  on 23.3.25..
//

import XCTest

class RepoListViewModelTest: XCTestCase {
    
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
        
        let viewModel = RepoListViewModel(repoListService: RepoListService(networkService: mockService))
        
        Task {
            await viewModel.fetchUserRepos(username: "validUsername")
            
            XCTAssertEqual(viewModel.repoItems.count, 2)
            XCTAssertEqual(viewModel.reposCount, "Repos Count: 2")
            XCTAssertEqual(viewModel.repoItems.first?.repoName, "Repo1")
        }
    }
    
    func testFetchUserReposSuccessEmpty() {
        let testRepos: [Repo] = []
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(testRepos))
        mockService.setMockResponse(mockResponse)
        
        let viewModel = RepoListViewModel(repoListService: RepoListService(networkService: mockService))
        
        Task {
            await viewModel.fetchUserRepos(username: "validUsername")
            
            XCTAssertEqual(viewModel.repoItems.count, 0)
            XCTAssertEqual(viewModel.reposCount, "Repos Count: 0")
        }
    }
    
    func testIsLoading() {
        let testRepos = [Repo]()
        let mockResponse = MockResponse.success(try! JSONEncoder().encode(testRepos))
        mockService.setMockResponse(mockResponse)
        let viewModel = RepoListViewModel(repoListService: RepoListService(networkService: mockService))
        
        XCTAssertFalse(viewModel.isLoading)
        Task {
            await viewModel.fetchUserRepos(username: "validUsername")
            XCTAssertFalse(viewModel.isLoading)
        }
    }
    
    func testFetchUserReposApplicationError() {
        let mockResponse = MockResponse.applicationError(ApplicationError(
                                message: "Invalid request", statusCode: 400))
        mockService.setMockResponse(mockResponse)
        let viewModel = RepoListViewModel(repoListService: RepoListService(networkService: mockService))
        
        Task {
            await viewModel.fetchUserRepos(username: "invalidUsername")
            
            XCTAssertNotNil(viewModel.error)
            XCTAssertEqual(viewModel.error?.message, "Invalid request")
            XCTAssertEqual(viewModel.error?.statusCode, 400)
        }
    }
    
    func testFetchUserReposErrorState() {
        let mockResponse = MockResponse.applicationError(ApplicationError(
                                message: "Invalid request", statusCode: 400))
        mockService.setMockResponse(mockResponse)
        let viewModel = RepoListViewModel(repoListService: RepoListService(networkService: mockService))
        
        Task {
            await viewModel.fetchUserRepos(username: "invalidUsername")
            
            XCTAssertNil(viewModel.repoItems)
            XCTAssertEqual(viewModel.reposCount, "")
        }
    }
}
