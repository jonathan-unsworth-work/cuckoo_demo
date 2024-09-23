import Cuckoo
import XCTest
@testable import CuckooDemo

final class DataViewModelTests: XCTestCase {

    var mockRepository: MockDataRepositoryProtocol!
    var viewModel: DataViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockDataRepositoryProtocol()
        viewModel = DataViewModel(repository: mockRepository)
    }
        
    func testLoadDataSuccess() {
        // Arrange
        let mockData = Data()
        stub(mockRepository) { stub in
            when(stub.getData(completion: any())).then { completion in
                completion(.success(mockData))
            }
        }
        
        // Act & Assert
        let expectation = XCTestExpectation(description: "Data callback is called")
        
        viewModel.data = { data in
            XCTAssertEqual(data, mockData)
            expectation.fulfill()
        }
        
        viewModel.loadData()
        
        wait(for: [expectation], timeout: 1.0)
        verify(mockRepository).getData(completion: any())
    }
    
    func testLoadDataFailure() {
        // Arrange
        let mockError = NSError(domain: "TestError", code: 0, userInfo: nil)
        stub(mockRepository) { stub in
            when(stub.getData(completion: any())).then { completion in
                completion(.failure(mockError))
            }
        }
        
        // Act & Assert
        let expectation = XCTestExpectation(description: "Error callback is called")
        
        viewModel.error = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        viewModel.loadData()
        
        wait(for: [expectation], timeout: 1.0)
        verify(mockRepository).getData(completion: any())
    }
}
