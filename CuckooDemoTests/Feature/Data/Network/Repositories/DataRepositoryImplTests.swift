import Cuckoo
import XCTest
@testable import CuckooDemo

final class DataRepositoryImplTests: XCTestCase {

    var mockService: MockDataServiceProtocol!
    var repository: DataRepositoryImpl!
    
    override func setUpWithError() throws {
        mockService = MockDataServiceProtocol()
        repository = DataRepositoryImpl(service: mockService)
    }
        
    func testGetData() {
        // Arrange
        let mockData = Data()
        stub(mockService) { stub in
            when(stub.fetchData(completion: any())).then { completion in
                completion(.success(mockData))
            }
        }
        
        // Act
        var result: Data?
        repository.getData { res in
            if case .success(let data) = res {
                result = data
            }
        }
        
        // Assert
        XCTAssertEqual(result, mockData)
        verify(mockService).fetchData(completion: any())
    }

}
