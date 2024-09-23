import Foundation

protocol APIService {
    func fetchData() -> String
}

class DataService {
    private let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func getData() -> String {
        return apiService.fetchData()
    }
}

