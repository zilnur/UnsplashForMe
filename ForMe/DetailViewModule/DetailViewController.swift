//
//  DetailViewController.swift
//  ForMe
//
//  Created by Ильнур Закиров on 14.10.2022.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: DetailViewInputProtocol
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let autorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.shadowColor = .black
        view.shadowOffset = CGSize(width: 1, height: 1)
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.shadowColor = .black
        view.shadowOffset = CGSize(width: 1, height: 1)
        return view
    }()
    
    let locationNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.shadowColor = .black
        view.shadowOffset = CGSize(width: 1, height: 1)
        return view
    }()
    
    let downloadsLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.shadowColor = .black
        view.shadowOffset = CGSize(width: 1, height: 1)
        return view
    }()
    
    lazy var likedButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemPink
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    
    //MARK: -Init
    init(presenter: DetailViewInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Metods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupValues()
    }
    
    private func setupViews() {
        view.backgroundColor = .black
        [photoImageView, autorLabel, dateLabel, locationNameLabel, downloadsLabel, likedButton].forEach(view.addSubview(_:))
        
        photoImageView.anchors(top: view.safeAreaLayoutGuide.topAnchor,
                               leading: view.leadingAnchor,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               trailing: view.trailingAnchor)
        downloadsLabel.anchors(top: nil,
                               leading: view.leadingAnchor,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               trailing: nil,
                               padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))
        locationNameLabel.anchors(top: nil,
                                  leading: view.leadingAnchor,
                                  bottom: downloadsLabel.topAnchor,
                                  trailing: nil,
                                  padding: UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0))
        dateLabel.anchors(top: nil,
                          leading: view.leadingAnchor,
                          bottom: locationNameLabel.topAnchor,
                          trailing: nil,
                          padding: UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0))
        autorLabel.anchors(top: nil,
                           leading: view.leadingAnchor,
                           bottom: dateLabel.topAnchor,
                           trailing: nil,
                           padding: UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 0))
        
        likedButton.anchors(top: nil,
                            leading: nil,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            trailing: view.trailingAnchor,
                            padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 30),
                            size: CGSize(width: 30, height: 30))
    }
    
    func setupValues() {
        photoImageView.download(from: presenter.setValues().imageUrl)
        autorLabel.text = presenter.setValues().autor
        dateLabel.text = presenter.setValues().createDate.toDate()
        locationNameLabel.text = presenter.setValues().location
        downloadsLabel.text = "Downloads: \(String(presenter.setValues().downloads))"
        likedButton.setImage(presenter.isLiked() ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
    
    @objc func buttonTapped() {
        if likedButton.currentImage == UIImage(systemName: "heart") {
            likedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            DataBaseService.shared.safeData(presenter.setValues())
        } else {
            likedButton.setImage(UIImage(systemName: "heart"), for: .normal)
            DataBaseService.shared.deleteData(presenter.deleteFromDataBase())
        }
        print(DataBaseService.shared.getData())
    }

}
