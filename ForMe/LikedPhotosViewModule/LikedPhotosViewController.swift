//
//  LikedPhotosViewController.swift
//  ForMe
//
//  Created by Ильнур Закиров on 14.10.2022.
//

import UIKit

class LikedPhotosViewController: UIViewController {
    
    // MARK: - Properties
    
    let presenter: LikedViewInputProtocol
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(LikedPhotosTableViewCell.self, forCellReuseIdentifier: "liked")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    //MARK: - Init
    
    init(presenter: LikedViewInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Metods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.anchors(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor)
    }
}

// MARK: - Extensions
extension LikedPhotosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "liked", for: indexPath) as? LikedPhotosTableViewCell
        presenter.setTable(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(presenter.toNextModule(indexPath: indexPath), animated: true)
    }
    
}
