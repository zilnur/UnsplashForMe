//
//  CollectionViewCell.swift
//  ForMe
//
//  Created by Ильнур Закиров on 13.10.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var index: Int = 0
    
    let uiimageview: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .gray
        view.image = UIImage(systemName: "arrow.clockwise")
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        uiimageview.image = UIImage(systemName: "arrow.clockwise")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(uiimageview)
        uiimageview.anchors(top: contentView.topAnchor,
                            leading: contentView.leadingAnchor,
                            bottom: contentView.bottomAnchor,
                            trailing: contentView.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
