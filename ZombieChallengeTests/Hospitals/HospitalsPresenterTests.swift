//
//  HospitalsPresenterTests.swift
//  ZombieChallengeTests
//
//  Created by Alisa Sapmun on 18/3/21.
//

import XCTest
@testable import ZombieChallenge

class HospitalsPresenterTests: XCTestCase {

    var presenter: HospitalsPresenter!
    var presenterSpy: HospitalsPresenterSpy!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor() {
        presenter = HospitalsPresenter()
        presenterSpy = HospitalsPresenterSpy()
        presenter.viewController = presenterSpy
    }
    
    func testPresentHospitalsSuccess() {
        // Given
        let data = [
            Hospital(id: 1, name: "Samitivej Hospital", waitingList: [
                WaitingList(patientCount: 7, levelOfPain: 0, averageProcessTime: 34),
                WaitingList(patientCount: 1, levelOfPain: 1, averageProcessTime: 25),
                WaitingList(patientCount: 14, levelOfPain: 2, averageProcessTime: 10),
                WaitingList(patientCount: 21, levelOfPain: 3, averageProcessTime: 45),
                WaitingList(patientCount: 4, levelOfPain: 4, averageProcessTime: 30)
            ])
        ]
        
        // When
        let response = HospitalsViewModel.GetHospitals.Response(hospitals: .success(result: data))
        presenter.presentHospitals(response: response)
        
        // Then
        XCTAssert(presenterSpy.displayHospitalsCalled, "presentHospitals() should ask view controller displayHospitals()")
    }
    
    func testPresentHospitalsFailed() {
        // Given
        let error = APIError.invalidRequest
        
        // When
        let response = HospitalsViewModel.GetHospitals.Response(hospitals: .failure(error: error))
        presenter.presentHospitals(response: response)
        
        // Then
        XCTAssert(presenterSpy.displayHospitalsCalled, "presentHospitals() should ask view controller displayHospitals()")
    }
    
}

class HospitalsPresenterSpy: HospitalsViewControllerProtocol {
    var displayHospitalsCalled = false
    func displayHospitals(viewModel: HospitalsViewModel.GetHospitals.ViewModel) {
        displayHospitalsCalled = true
    }
}
