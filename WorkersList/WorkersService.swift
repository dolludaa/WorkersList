import Foundation

class WorkersService {
    
    func fetchResultsFromApi(completion: @escaping (Result<WorkersList, Error>) -> Void) {
        
        let dataUrl = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        
        guard let url = URL(string: dataUrl) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response , error in
            
            guard data != nil else { return }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(WorkersList.self, from: data)
                
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                        return
                }
                
                if data == data  {
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                }
                
            } catch {
                print(error)
            }
        }
        .resume()
    }
}
