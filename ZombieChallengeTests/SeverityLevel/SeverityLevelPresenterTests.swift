//
//  SeverityLevelPresenterTests.swift
//  ZombieChallengeTests
//
//  Created by Alisa Sapmun on 18/3/21.
//

import XCTest
@testable import ZombieChallenge

class SeverityLevelPresenterTests: XCTestCase {

    var presenter: SeverityLevelPresenter!
    var presenterSpy: SeverityLevelPresenterSpy!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor() {
        presenter = SeverityLevelPresenter()
        presenterSpy = SeverityLevelPresenterSpy()
        presenter.viewController = presenterSpy
    }
    
    func testPresentSavePatientInfoSuccess() {
        // Given
        let data = true
        
        // When
        let response = SeverityLevelViewModel.SavePatientInfo.Response(isSuccess: .success(result: data))
        presenter.presentSavePatientInfo(response: response)

        // Then
        XCTAssert(presenterSpy.displaySavePatientInfoCalled, "presentSavePatientInfo() should ask view controller displaySavePatientInfo()")
    }
    
    func testPresentSavePatientInfoFailed() {
        // Given
        let error = APIError.invalidRequest
        
        // When
        let response = SeverityLevelViewModel.SavePatientInfo.Response(isSuccess: .failure(error: error))
        presenter.presentSavePatientInfo(response: response)
        
        // Then
        XCTAssert(presenterSpy.displaySavePatientInfoCalled, "presentSavePatientInfo() should ask view controller displaySavePatientInfo()")
    }
}

class SeverityLevelPresenterSpy: SeverityLevelViewControllerProtocol {
    var displaySavePatientInfoCalled = false
    func displaySavePatientInfo(viewModel: SeverityLevelViewModel.SavePatientInfo.ViewModel) {
        displaySavePatientInfoCalled = true
    }
}
