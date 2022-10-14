import Foundation
import RealmSwift

class Photo: Object {
    
    @Persisted var id: String
    @Persisted var createDate: String
    @Persisted var imageUrl: String
    @Persisted var autor: String
    @Persisted var location: String
    @Persisted var downloads: Int
    @Persisted var sizeProportion: Double
    
    convenience init(id: String, createDate: String, imageUrl: String, autor: String, location: String, downloads: Int, sizeProportion: Double) {
        self.init()
        self.id = id
        self.createDate = createDate
        self.imageUrl = imageUrl
        self.autor = autor
        self.location = location
        self.downloads = downloads
        self.sizeProportion = sizeProportion
    }
}

class DataBaseService {
    
    let realm = try! Realm()
    
    static let shared = DataBaseService()
    
    func safeData(_ data: PhotoModel) {
        let newData = Photo(id: data.id,
                            createDate: data.createDate,
                            imageUrl: data.imageUrl,
                            autor: data.autor,
                            location: data.location,
                            downloads: data.downloads,
                            sizeProportion: data.sizeProportion)
        try! realm.write({
            realm.add(newData)
        })
    }
    
    func getData() -> Results<Photo> {
        let data = realm.objects(Photo.self)
        return data
    }
    
    func deleteData(_ data: Photo?) {
        guard let data = data else { return }
        try! realm.write({
            realm.delete(data)
        })
    }
}
