//
//  PhotoCollectionViewCell.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 04.03.2023.
//

import UIKit
import SnapKit

class PhotoGalleryCell: UICollectionViewCell {
    
    var photoURL: String? {
        didSet {
            guard let photoURL else { return }
            photoImageView.image = UIImage(named: photoURL)
        }
    }
    
    private lazy var photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
//        contentView.backgroundColor = .systemGreen
        
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
