import Cuckoo
import XCTest
@testable import CuckooDemo

final class DataServiceImplTests: XCTestCase {
    
    var mockService: MockDataServiceProtocol!

    override func setUpWithError() throws {
        mockService = MockDataServiceProtocol()
    }
    
    func testFetchDataSuccess() {
        // Arrange
        let mockData = Data()
        stub(mockService) { stub in
            when(stub.fetchData(completion: any())).then { completion in
                completion(.success(mockData))
            }
        }
        
        // Act
        var result: Data?
        mockService.fetchData { res in
            if case .success(let data) = res {
                result = data
            }
        }
        
        // Assert
        XCTAssertEqual(result, mockData)
        verify(mockService).fetchData(completion: any())
    }
    
    func testFetchDataFailure() {
            // Arrange
            let mockError = NSError(domain: "TestError", code: 0, userInfo: nil)
            stub(mockService) { stub in
                when(stub.fetchData(completion: any())).then { completion in
                    completion(.failure(mockError))
                }
            }
            
            // Act
            var error: Error?
            mockService.fetchData { res in
                if case .failure(let err) = res {
                    error = err
                }
            }
            
            // Assert
            XCTAssertNotNil(error)
            verify(mockService).fetchData(completion: any())
        }
}
