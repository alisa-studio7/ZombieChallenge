//
//  HospitalsInteractorTests.swift
//  ZombieChallengeTests
//
//  Created by Alisa Sapmun on 18/3/21.
//

import XCTest
@testable import ZombieChallenge

class HospitalsInteractorTests: XCTestCase {

    var interactor: HospitalsInteractor!
    var outputSpy: HospitalsInteractorSpy!
    var workerSpy: HospitalsWorkerSpy!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor() {
        interactor = HospitalsInteractor()
        outputSpy = HospitalsInteractorSpy()
        interactor.presenter = outputSpy
        workerSpy = HospitalsWorkerSpy()
        interactor.worker = workerSpy
    }
    
    func testGetIllnesses() {
        // When
        interactor.getHospitals(request: HospitalsViewModel.GetHospitals.Request(levelOfPain: 0))
        
        // Then
        XCTAssert(workerSpy.getHospitalsCalled, "worker should call getHospitals()")
        XCTAssert(outputSpy.presentHospitalsCalled, "getHospitals() should ask presenter to presentHospitals()")
    }

}

class HospitalsInteractorSpy: HospitalsPresenterProtocol {
    var presentHospitalsCalled = false
    
    func presentHospitals(response: HospitalsViewModel.GetHospitals.Response) {
        presentHospitalsCalled = true
    }
}

class HospitalsWorkerSpy: HospitalsWorkerProtocol {
    var isFailed = false
    var getHospitalsCalled = false
    
    func getHospitals(_ completion: @escaping (UserResult<Hospitals>) -> Void) {
        getHospitalsCalled = true
        if isFailed {
            let error = APIError.invalidRequest
            completion(.failure(error: error))
        } else {
            let hospitals = Hospitals(hospitals: [
                Hospital(id: 1, name: "Samitivej Hospital", waitingList: [
                    WaitingList(patientCount: 7, levelOfPain: 0, averageProcessTime: 34),
                    WaitingList(patientCount: 1, levelOfPain: 1, averageProcessTime: 25),
                    WaitingList(patientCount: 14, levelOfPain: 2, averageProcessTime: 10),
                    WaitingList(patientCount: 21, levelOfPain: 3, averageProcessTime: 45),
                    WaitingList(patientCount: 4, levelOfPain: 4, averageProcessTime: 30)
                ])
            ])
            completion(.success(result: hospitals))
        }
    }
}
