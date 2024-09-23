import Foundation

class DataViewModel {
    private let repository: DataRepositoryProtocol
    
    var data: ((Data?) -> Void)?
    var error: ((Error?) -> Void)?
    
    init(repository: DataRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadData() {
        repository.getData { [weak self] result in
            switch result {
            case .success(let data):
                self?.data?(data)
            case .failure(let error):
                self?.error?(error)
            }
        }
    }
}
