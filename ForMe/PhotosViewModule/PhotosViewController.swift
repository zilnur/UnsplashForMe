import UIKit

protocol PhotosViewOutputProtocol {
    func alerts(error: Error)
}

class PhotosViewController: UIViewController {
    
    // MARK: - Properties
    
    let presenter: PhotoViewInputProtocol
    
    let refreshControl = UIRefreshControl()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.refreshControl = refreshControl
        view.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.register(UICollectionViewCell.self, forSupplementaryViewOfKind: "list-header-element-kind", withReuseIdentifier: "reusableCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var searchBar : UISearchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        view.barStyle = .default
//        view.sizeToFit()
        return view
    }()
    //MARK: -Init
    
    init(presenter: PhotoViewInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -Metods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        refreshControl.beginRefreshing()
        presenter.setModel() {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [collectionView, searchBar].forEach(view.addSubview(_:))
        
        searchBar.anchors(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        collectionView.anchors(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }


}

// MARK: - Extensions
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell
        presenter.setCollectionData(cell: cell, indexPath: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 25) / 2
        let height = width * presenter.imageSizeProportion(indexPath: indexPath)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(presenter.toNextModule(indexPath: indexPath),
                                                 animated: true)
    }
}

extension PhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        presenter.setSortedModel(query: query) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension PhotosViewController: PhotosViewOutputProtocol {
    
    //Показывает алерт в случае ошибки загрузки
    func alerts(error: Error) {
        let alertController = UIAlertController(title: "Произошла ошибка", message: "Ошибка: \(error.localizedDescription)", preferredStyle: .alert)
        let alert = UIAlertAction(title: "Ок", style: .default)
        alertController.addAction(alert)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
