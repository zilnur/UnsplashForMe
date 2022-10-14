import Foundation

protocol DetailViewInputProtocol {
    func setValues() -> PhotoModel
    func isLiked() -> Bool
    func deleteFromDataBase() -> Photo?
}

class DetailViewPresenter: DetailViewInputProtocol {
    
    var model: PhotoModel
    let factory: Factory
    
    init(model: PhotoModel, factory: Factory) {
        self.model = model
        self.factory = factory
    }
    
    // Отдает модель
    func setValues() -> PhotoModel {
        model
    }
    
    //Проверяет добавлял ли пользователь фото в "Понравившиеся"
    func isLiked() -> Bool {
        DataBaseService.shared.getData().contains { element in
            element.id == model.id
        }
    }
    
    //Удаляет картинку из понравившихся
    func deleteFromDataBase() -> Photo? {
        let photo = DataBaseService.shared.getData().first {$0.id == model.id}
        return photo
    }
}
