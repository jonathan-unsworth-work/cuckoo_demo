import Cuckoo
import XCTest
@testable import CuckooDemo

final class DataServiceTests: XCTestCase {
    
    var mockAPIService: MockAPIService!
    var dataService: DataService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockAPIService = MockAPIService()
        dataService = DataService(apiService: mockAPIService)
    }
    
    func testGetData() {
        // Arrange: Stub the mock to return a specific value
        stub(mockAPIService) { mock in
            when(mock.fetchData()).thenReturn("Mock Data")
        }
        
        // Act: Call the method under test
        let result = dataService.getData()
        
        // Assert: Verify the behavior
        XCTAssertEqual(result, "Mock Data")
        verify(mockAPIService).fetchData()
    }
}
