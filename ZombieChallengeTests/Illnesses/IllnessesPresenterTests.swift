//
//  IllnessesPresenterTests.swift
//  ZombieChallengeTests
//
//  Created by Alisa Sapmun on 18/3/21.
//

import XCTest
@testable import ZombieChallenge

class IllnessesPresenterTests: XCTestCase {

    var presenter: IllnessesPresenter!
    var presenterSpy: IllnessPresenterSpy!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor() {
        presenter = IllnessesPresenter()
        presenterSpy = IllnessPresenterSpy()
        presenter.viewController = presenterSpy
    }
    
    func testPresentIllnessesSuccess() {
        // Given
        let data = [
            IllnessItem(name: "Mortal Cold", id: 1),
            IllnessItem(name: "Happy Euphoria", id: 2)
        ]
        
        // When
        let response = IllnessesViewModel.GetIllnesses.Response(illnesses: .success(result: data))
        presenter.presentIllnesses(response: response)
        
        // Then
        XCTAssert(presenterSpy.displayIllnessesCalled, "presentIllnesses() should ask view controller displayIllnesses()")
    }
    
    func testPresentIllnessesFailed() {
        // Given
        let error = APIError.invalidRequest
        
        // When
        let response = IllnessesViewModel.GetIllnesses.Response(illnesses: .failure(error: error))
        presenter.presentIllnesses(response: response)
        
        // Then
        XCTAssert(presenterSpy.displayIllnessesCalled, "presentIllnesses() should ask view controller displayIllnesses()")
    }
}

class IllnessPresenterSpy: IllnessesViewControllerProtocol {
    var displayIllnessesCalled = false

    func displayIllnesses(viewModel: IllnessesViewModel.GetIllnesses.ViewModel) {
        displayIllnessesCalled = true
    }
}
