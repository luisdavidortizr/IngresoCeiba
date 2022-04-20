//
//  MenuFetcherTests.swift
//  IngresoCeibaTests
//
//  Created by Luis David Ortiz on 19/04/22.
//

@testable import Prueba_de_Ingreso
import XCTest
import Combine

class UserFetcherTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_WhenUserRequestSucceeds_PublishesDecodedUsers() throws {
        let url = try XCTUnwrap(
            Bundle(for: type(of: self)).url(forResource: "users",withExtension: "json")
        )
        let data = try Data(contentsOf: url)
        
        let userFetcher = UserFetcher(networkFetching: NetworkFetchingStub(returning: .success(data)))
        
        let expectation = XCTestExpectation(description: "Publishes decoded [User]")
        
        userFetcher.fetchUsers()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { items in
                    XCTAssertEqual(items.count, 10)
                    XCTAssertEqual(items.first?.name, "Leanne Graham")
                    XCTAssertEqual(items.last?.name, "Clementina DuBuque")
                    expectation.fulfill()
                }
            ).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_WhenUserRequestFails_PublishesReceivedErrors() {
        let expectedError = URLError(.badServerResponse)
        let userFetcher = UserFetcher(networkFetching: NetworkFetchingStub(returning: .failure(expectedError)))
        
        let expectation = XCTestExpectation(description: "Publishes received URLError")
        
        userFetcher.fetchUsers()
            .sink(receiveCompletion: { completion in
                    guard case .failure(let error) = completion else { return }
                    XCTAssertEqual(error as? URLError, expectedError)
                    expectation.fulfill()
                  }, receiveValue: { items in
                      XCTFail("Expected to fail, succeeded with \(items)")
                  }
            ).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_WhenPostsRequestSucceeds_PublishesDecodedPosts() throws {
        let url = try XCTUnwrap(
            Bundle(for: type(of: self)).url(forResource: "posts",withExtension: "json")
        )
        let data = try Data(contentsOf: url)
        
        let userFetcher = UserFetcher(networkFetching: NetworkFetchingStub(returning: .success(data)))
        
        let expectation = XCTestExpectation(description: "Publishes decoded [Post]")
        
        userFetcher.fetchPosts(userId: 1)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { items in
                    XCTAssertEqual(items.count, 10)
                    XCTAssertEqual(items.first?.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
                    XCTAssertEqual(items.last?.title, "optio molestias id quia eum")
                    expectation.fulfill()
                }
            ).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_WhenPostsRequestFails_PublishesReceivedErrors() {
        let expectedError = URLError(.badServerResponse)
        let userFetcher = UserFetcher(networkFetching: NetworkFetchingStub(returning: .failure(expectedError)))
        
        let expectation = XCTestExpectation(description: "Publishes received URLError")
        
        userFetcher.fetchPosts(userId: 1)
            .sink(receiveCompletion: { completion in
                    guard case .failure(let error) = completion else { return }
                    XCTAssertEqual(error as? URLError, expectedError)
                    expectation.fulfill()
                  }, receiveValue: { items in
                      XCTFail("Expected to fail, succeeded with \(items)")
                  }
            ).store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
}
