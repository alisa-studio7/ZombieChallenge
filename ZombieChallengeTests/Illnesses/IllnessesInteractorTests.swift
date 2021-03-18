//
//  IllnessesInteractorTests.swift
//  ZombieChallengeTests
//
//  Created by Alisa Sapmun on 18/3/21.
//

import XCTest
@testable import ZombieChallenge

class IllnessesInteractorTests: XCTestCase {

    var interactor: IllnessesInteractor!
    var outputSpy: IllnessesInteractorSpy!
    var workerSpy: IllnessesWorkerSpy!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor() {
        interactor = IllnessesInteractor()
        outputSpy = IllnessesInteractorSpy()
        interactor.presenter = outputSpy
        workerSpy = IllnessesWorkerSpy()
        interactor.worker = workerSpy
    }
    
    func testGetIllnesses() {
        // When
        interactor.getIllnesses(request: IllnessesViewModel.GetIllnesses.Request())
        
        // Then
        XCTAssert(workerSpy.getIllnessesCalled, "worker should call getIllnesses()")
        XCTAssert(outputSpy.presentIllnessesCalled, "getIllnesses() should ask presenter to presentIllnesses()")
    }
}

class IllnessesInteractorSpy: IllnessesPresenterProtocol {
    var presentIllnessesCalled = false
    
    func presentIllnesses(response: IllnessesViewModel.GetIllnesses.Response) {
        presentIllnessesCalled = true
    }
}

class IllnessesWorkerSpy: IllnessesWorkerProtocol {
    var isFailed = false
    var getIllnessesCalled = false
    
    func getIllnessList(_ completion: @escaping (UserResult<IllnessList>) -> Void) {
        getIllnessesCalled = true
        if isFailed {
            let error = APIError.invalidRequest
            completion(.failure(error: error))
        } else {
            let data = IllnessList(illnesses: [
                                    Illness(illness: IllnessItem(name: "Mortal Cold", id: 1)),
                                    Illness(illness: IllnessItem(name: "Happy Euphoria", id: 2))
            ])
            completion(.success(result: data))
        }
    }
}
