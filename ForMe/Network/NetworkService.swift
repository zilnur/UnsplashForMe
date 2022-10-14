import Foundation

enum Paths: String {
    case random = "/photos/random/"
    case photo = "/photos/"
}

class NetworkService {
    
    private let accessKey = "ZI7InEq5HpJ-47mCOhbeiUTuqS8GLgORV5lZmoHoX9Y"
    
    private func url(path: String, queryItems: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = path
        components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func sessionDataTask(path: String, queryItems: [String: String], completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        var items = queryItems
        items["client_id"] = accessKey
        let url = self.url(path: path, queryItems: items)
        print(url)
        let request = URLRequest(url: url)
        return URLSession.shared.dataTask(with: request) { data, _, error in
            completion(data, error)
        }
    }
    
    private func jsonDecoded<T:Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data,
              let responce = try? decoder.decode(type.self, from: data) else {
            print("Ooops!")
            return nil
        }
        
        return responce
    }
    
    // Получаем данные по указанным пути и параметрам
    func getData(path: Paths, queryItems: [String: String] = [:] ,completion: @escaping (Result<[RandomPhotos],Error>) -> Void) {
        let task = self.sessionDataTask(path: path.rawValue, queryItems: queryItems) { data, error in
            if error != nil {
                completion(.failure(error!))
            }
            guard let data = data else {
                return
            }
            if let decoded = self.jsonDecoded(type: [RandomPhotos].self, data: data) {
             completion(.success(decoded))
            }
        }
        task.resume()
    }
}
