import Foundation
import UIKit

extension UIImageView {
    func download(from: String) {
        guard let url = URL(string: from) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        session.resume()
    }
}
