//
//  LikedPhotosTableViewCell.swift
//  ForMe
//
//  Created by Ильнур Закиров on 14.10.2022.
//

import UIKit

class LikedPhotosTableViewCell: UITableViewCell {

    let photoImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "arrow.clockwise")
        view.tintColor = .gray
        return view
    }()
    
    let autorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = UIImage(systemName: "arrow.clockwise")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [photoImage, autorLabel].forEach(contentView.addSubview(_:))
        
        photoImage.anchors(top: contentView.topAnchor,
                           leading: contentView.leadingAnchor,
                           bottom: contentView.bottomAnchor,
                           trailing: nil,
                           padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0),
        size: CGSize(width: 200, height: 200))
        autorLabel.anchors(top: contentView.topAnchor,
                           leading: photoImage.trailingAnchor,
                           bottom: nil,
                           trailing: contentView.trailingAnchor,
                           padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
    }
}
