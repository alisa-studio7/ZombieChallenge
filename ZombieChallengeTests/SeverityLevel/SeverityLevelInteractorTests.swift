//
//  SeverityLevelInteractorTests.swift
//  ZombieChallengeTests
//
//  Created by Alisa Sapmun on 18/3/21.
//

import XCTest
@testable import ZombieChallenge

class SeverityLevelInteractorTests: XCTestCase {

    var interactor: SeverityLevelInteractor!
    var outputSpy: SeverityLevelInteractorSpy!
    var workerSpy: SeverityLevelWorkerSpy!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor() {
        interactor = SeverityLevelInteractor()
        outputSpy = SeverityLevelInteractorSpy()
        interactor.presenter = outputSpy
        workerSpy = SeverityLevelWorkerSpy()
        interactor.worker = workerSpy
    }
    
    func testGetIllnesses() {
        // When
        interactor.savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request(illness: IllnessItem(name: "Happy Euphoria", id: 1), levelOfPain: 0))
        
        // Then
        XCTAssert(workerSpy.savePatientInfoCalled, "worker should call savePatientInfo()")
        XCTAssert(outputSpy.presentSavePatientInfoCalled, "savePatientInfo() should ask presenter to presentSavePatientInfo()")
    }
}

class SeverityLevelInteractorSpy: SeverityLevelPresenterProtocol {
    var presentSavePatientInfoCalled = false
    func presentSavePatientInfo(response: SeverityLevelViewModel.SavePatientInfo.Response) {
        presentSavePatientInfoCalled = true
    }
}

class SeverityLevelWorkerSpy: SeverityLevelWorkerProtocol {
    var isFailed = false
    var savePatientInfoCalled = false
    
    func savePatientInfo(request: SeverityLevelViewModel.SavePatientInfo.Request, _ completion: @escaping (UserResult<Bool>) -> Void) {
        savePatientInfoCalled = true
        if isFailed {
            let error = APIError.invalidRequest
            completion(.failure(error: error))
        } else {
            completion(.success(result: true))
        }
    }
}
