import Foundation

protocol DataServiceProtocol {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void)
}

final class DataServiceImpl: DataServiceProtocol {
    func fetchData(completion: @escaping (Result<Data, any Error>) -> Void) {
        // Implementation of network call
    }
}
