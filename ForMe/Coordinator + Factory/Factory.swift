import Foundation
import UIKit

class Factory {
    func makeTabBarController(viewControllers: [UIViewController]) -> UITabBarController {
        let tabbc = UITabBarController()
        tabbc.viewControllers = viewControllers
        tabbc.tabBar.backgroundColor = .white
        return tabbc
    }
    
    func makePhotosModule(network: NetworkService) -> UINavigationController {
        let presenter = PhotosPresenter(factory: self, network: network)
        let view = PhotosViewController(presenter: presenter)
        let nvc = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nvc.navigationBar.scrollEdgeAppearance = appearance
        nvc.tabBarItem = UITabBarItem(title: "Фото", image: UIImage(systemName: "photo"), tag: 0)
        return nvc
    }
    
    func makeDetailModule(model: PhotoModel) -> UIViewController {
        let presenter = DetailViewPresenter(model: model,factory: self)
        let view = DetailViewController(presenter: presenter)
        return view
    }
    
    func makeLikedModule() -> UINavigationController {
        let presenter = LikedModulePresenter(factory: self)
        let view = LikedPhotosViewController(presenter: presenter)
        let nvc = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nvc.navigationBar.scrollEdgeAppearance = appearance
        nvc.tabBarItem = UITabBarItem(title: "Понравившиеся", image: UIImage(systemName: "heart"), tag: 1)
        return nvc
    }
}
