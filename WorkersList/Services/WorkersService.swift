import Foundation

class WorkersService {
    
    private var lastDataRequestTime: Date?
    
    func fetchResultsFromApi(completion: @escaping (Result<WorkersList, Error>) -> Void) {
        
        if let lastDataRequestTime {
            
            let currentDate = Date()
            let timeIntervalInSeconds = currentDate.timeIntervalSince(lastDataRequestTime)
            
            if timeIntervalInSeconds > 10 {
                requestRemoteData(policy: .reloadIgnoringCacheData, completion: completion)
            } else {
                requestRemoteData(policy: .returnCacheDataElseLoad, completion: completion)
            }
            
        } else {
            requestRemoteData(policy: .reloadIgnoringCacheData, completion: completion)
        }
    }
    
    private func requestRemoteData(policy: URLRequest.CachePolicy, completion: @escaping (Result<WorkersList, Error>) -> Void) {
        
        let dataUrl = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        
        guard let url = URL(string: dataUrl) else { return }
        
        let request = URLRequest(url: url, cachePolicy: policy)
        
        URLSession.shared.dataTask(with: request) { data, response , error in
            
            guard data != nil else { return }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode(WorkersList.self, from: data)
                
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                if data == data {
                    DispatchQueue.main.async { [weak self] in
                        completion(.success(jsonData))
                        self?.lastDataRequestTime = Date()
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
}
