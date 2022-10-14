import Foundation

struct RandomPhotos: Codable {
    let id: String
    let createdAt: String?
    let downloads: Int
    let location: Location
    let urls: Urls
    let width: Double
    let height: Double
    let user: User
}

struct Location: Codable {
    let name: String?
}

struct Urls: Codable {
    let full: String
    let regular: String
    let small: String
    let raw: String
    let thumb: String
    let smallS3: String
}

struct User: Codable {
    let name: String
}
