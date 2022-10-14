import Foundation
import UIKit

protocol LikedViewInputProtocol {
    func numberOfCells() -> Int
    func setTable(cell: LikedPhotosTableViewCell?, indexPath: IndexPath)
    func toNextModule(indexPath: IndexPath) -> UIViewController
}

class LikedModulePresenter: LikedViewInputProtocol {
    
    let model = DataBaseService.shared.getData()
    let factory: Factory
    
    init(factory: Factory) {
        self.factory = factory
    }
    
    //Устанавливает количество ячеек
    func numberOfCells() -> Int {
        model.count
    }
    
    //Заполняет таблицу
    func setTable(cell: LikedPhotosTableViewCell?, indexPath: IndexPath) {
        cell?.photoImage.download(from: model[indexPath.item].imageUrl)
        cell?.autorLabel.text = model[indexPath.item].autor
    }
    
    //Переход на следующий модуль
    func toNextModule(indexPath: IndexPath) -> UIViewController {
        let newModel = PhotoModel(id: model[indexPath.item].id,
                                  createDate: model[indexPath.item].createDate,
                                  imageUrl: model[indexPath.item].imageUrl,
                                  autor: model[indexPath.item].autor,
                                  location: model[indexPath.item].location,
                                  downloads: model[indexPath.item].downloads,
                                  sizeProportion: model[indexPath.item].sizeProportion)
        return factory.makeDetailModule(model: newModel)
    }
}
