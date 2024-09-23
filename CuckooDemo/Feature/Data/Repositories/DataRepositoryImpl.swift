import Foundation

protocol DataRepositoryProtocol {
    func getData(completion: @escaping (Result<Data, Error>) -> Void)
}

class DataRepositoryImpl: DataRepositoryProtocol {
    private let service: DataServiceProtocol
    
    init(service: DataServiceProtocol) {
        self.service = service
    }
    
    func getData(completion: @escaping (Result<Data, Error>) -> Void) {
        service.fetchData(completion: completion)
    }
}
