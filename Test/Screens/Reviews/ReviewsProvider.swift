import Foundation
import UIKit
/// Класс для загрузки отзывов.
final class ReviewsProvider {
    
    private let bundle: Bundle
    
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
}

// MARK: - Internal

extension ReviewsProvider {
    
    typealias GetReviewsResult = Result<Data, GetReviewsError>
    
    enum GetReviewsError: Error {
        
        case badURL
        case badData(Error)
        
    }
    
    func getReviews(offset: Int = 0, completion: @escaping (GetReviewsResult) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let url = self?.bundle.url(forResource: "getReviews.response", withExtension: "json") else {
                return completion(.failure(.badURL))
            }
            
            // Симулируем сетевой запрос - не менять
            usleep(.random(in: 100_000...1_000_000))
            
            do {
                let data = try Data(contentsOf: url)
                completion(.success(data))
            } catch {
                completion(.failure(.badData(error)))
            }
        }
    }
    
    func getUserAvatar(urlString: String, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            if let cachedImage = ImageCache.shared.image(forKey: urlString) {
                completion(cachedImage)
            } else {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else {
                        completion(nil)
                        return
                    }
                    
                    let image = UIImage(data: data)
                    if let image = image{
                        ImageCache.shared.saveImage(image, forKey: urlString)
                    }
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }.resume()
            }
        }
    }
}
