//
//  FishesTests.swift
//  FishesTests
//
//  Created by Devs on 2022-09-07.
//

import XCTest
@testable import Fishes

class FishesTests: XCTestCase {
    var sutListVm: SpeciesListViewModel!
    var mockApiService: ApiServiceProtocol!
    var mockCoordinator: MockCoordinator!
    var navigationController: UINavigationController!

    
    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApiService = MockApiService()
        navigationController = UINavigationController(rootViewController: UIViewController())
        mockCoordinator = MockCoordinator(navigationController: navigationController)
        
        sutListVm = SpeciesListViewModel(nav: mockCoordinator, apiService: mockApiService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockApiService = nil
        mockCoordinator = nil
        navigationController = nil

        sutListVm = nil
        try super.tearDownWithError()
    }
    
    func testFetchSpeciesFromAPI() throws {
        sutListVm.loadSpeciesFromAPI()
        XCTAssert((mockApiService as! MockApiService).isGetAllSpeciesCalled)
    }

    func testFailedFetchSpeciesFromApi() throws {
        let err = ApiError.connectionError
        
        sutListVm.loadSpeciesFromAPI()
        (mockApiService as! MockApiService).getAllFailure(error: err)
        
        if case .error(let error) = sutListVm.state {
            XCTAssert(error is ApiError)
        } else {
            XCTFail()
        }
    }
    
    func testCoordinatorLaunch() throws {
        mockCoordinator.launch()
        XCTAssertTrue(mockCoordinator.wentToListView)
    }

    func testGoToDetailsView() throws {
        sutListVm.goToDetailsView(tappedSpecies: Species(name: "Torsk", scientificName: "Torskus Fiskus", population: "n/a", images: []))
        XCTAssertTrue(mockCoordinator.wentToDetailsView)
    }
}
