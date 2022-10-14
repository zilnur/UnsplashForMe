import Foundation
import UIKit

protocol PhotoViewInputProtocol {
    func setModel(comletion: @escaping () -> ())
    func setSortedModel(query: String,completion: @escaping () -> Void)
    func setCollectionData(cell: CollectionViewCell?, indexPath: IndexPath)
    func numberOfRows() -> Int
    func imageSizeProportion(indexPath: IndexPath) -> CGFloat
    func toNextModule(indexPath: IndexPath) -> UIViewController
}

class PhotosPresenter: PhotoViewInputProtocol {
    
    let network: NetworkService
    var model: [PhotoModel] = []
    let factory: Factory
    
    init(factory: Factory, network: NetworkService) {
        self.factory = factory
        self.network = network
    }
    
    //Загружает случайные фотографии и заполняет модель
    func setModel(comletion: @escaping () -> ()) {
        network.getData(path: Paths.random, queryItems: ["count":"30"]) { result in
            switch result {
            case .success(let model):
                model.forEach { photo in
                    let model = PhotoModel(id: photo.id,
                                           createDate: photo.createdAt ?? "",
                                           imageUrl: photo.urls.smallS3,
                                           autor: photo.user.name ,
                                           location: photo.location.name ?? "",
                                           downloads: photo.downloads,
                                           sizeProportion: photo.height / photo.width)
                    self.model.append(model)
                }
                self.model = self.model.sorted {$0.sizeProportion < $1.sizeProportion}
                comletion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //Загружет фотографии по заданному запросу и обновляет модель
    func setSortedModel(query: String,completion: @escaping () -> Void) {
        network.getData(path: Paths.random, queryItems: ["query": query, "count":"30"]) { result in
            switch result {
            case .success(let photos):
                self.model.removeAll()
                photos.forEach { photo in
                    let model = PhotoModel(id: photo.id,
                                           createDate: photo.createdAt ?? "",
                                           imageUrl: photo.urls.smallS3,
                                           autor: photo.user.name,
                                           location: photo.location.name ?? "",
                                           downloads: photo.downloads,
                                           sizeProportion: photo.height / photo.width)
                    self.model.append(model)
                    self.model = self.model.sorted {$0.sizeProportion < $1.sizeProportion}
                    completion()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //Заполняет коллекцию
    func setCollectionData(cell: CollectionViewCell?, indexPath: IndexPath) {
            cell?.uiimageview.download(from: model[indexPath.item].imageUrl)
    }
    
    //Указывает количество ячеек в коллекции
    func numberOfRows() -> Int {
        model.count
    }
    
    //Пропорции для размеров ячейки
    func imageSizeProportion(indexPath: IndexPath) -> CGFloat {
        CGFloat(model[indexPath.item].sizeProportion)
    }
    
    //Переход на следующий модуль
    func toNextModule(indexPath: IndexPath) -> UIViewController {
        factory.makeDetailModule(model: model[indexPath.item])
    }
}


