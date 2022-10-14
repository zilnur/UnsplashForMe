import Foundation

extension String {
    func toDate() -> String {
        let oldFormatter = DateFormatter()
        oldFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = oldFormatter.date(from: self)
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "dd.MM.yyyy"
        let string = newFormatter.string(from: date ?? Date())
        return string
    }
}
