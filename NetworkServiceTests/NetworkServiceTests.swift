//
//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by Руслан Усманов on 17.01.2024.
//

import XCTest
@testable import NetworkService

final class NetworkServiceTests: XCTestCase {
    let mockDataTaskService = MockDataTaskService()
    lazy var service = NetworkService(service: mockDataTaskService)
    
    func testRequestWithError() {
        let expectation = expectation(description: "Expectation")
        
        mockDataTaskService.error = MockError.mockError
        guard let url = URL(string: "https://www.google.com") else {
            print("error")
            return
        }
        service.request(url: url)
        if service.resultStatus == .requestError {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func testRequestWithInvalidResponce(){
        let expectation = expectation(description: "Expectation")
        
        mockDataTaskService.error = nil
        
        guard let url = URL(string: "https://www.google.com") else {
            print("error")
            return
        }
        mockDataTaskService.responce = HTTPURLResponse(url: url, statusCode: 404 , httpVersion: nil, headerFields: nil)
        service.request(url: url)
        if service.resultStatus == .badResponce {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func testRequestWithEmptyData(){
        let expectation = expectation(description: "Expectation")
        
        mockDataTaskService.error = nil
        mockDataTaskService.data = nil
        
        guard let url = URL(string: "https://www.google.com") else {
            print("error")
            return
        }
        mockDataTaskService.responce = HTTPURLResponse(url: url, statusCode: 200 , httpVersion: nil, headerFields: nil)
        service.request(url: url)
        if service.resultStatus == .empty {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func testSuccessfulRequest(){
        let expectation = expectation(description: "Expectation")
        
        mockDataTaskService.error = nil
        mockDataTaskService.data = Data(capacity: 1)
        
        guard let url = URL(string: "https://www.google.com") else {
            print("error")
            return
        }
        mockDataTaskService.responce = HTTPURLResponse(url: url, statusCode: 200 , httpVersion: nil, headerFields: nil)
        service.request(url: url)
        if service.resultStatus == .success {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
}
