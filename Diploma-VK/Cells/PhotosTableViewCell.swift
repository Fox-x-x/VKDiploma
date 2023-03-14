//
//  PhotosTableViewCell.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 18.02.2023.
//

import UIKit
import SnapKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var photoImageViews: [UIImageView] = [firstPhoto, secondPhoto, thirdPhoto, fourthPhoto]
    
    var photos: [String]? {
        didSet {
            guard let photos = photos else { return }
            
            for (index, value) in photos.enumerated() {
                photoImageViews[index].image = UIImage(named: value)
            }
        }
    }
    
    private lazy var firstPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // Второе фото
    private lazy var secondPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // Третье фото
    private lazy var thirdPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // Четвертое фото
    private lazy var fourthPhoto: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        photo.backgroundColor = .white
        return photo
    }()
    
    // label с текстом "Photos"
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = ColorPalette.thirdColor
        label.numberOfLines = 1
        label.text = "Фотографии"
        return label
    }()
    
    // стрелка
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = ColorPalette.thirdColor
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: вычисляем ширину для каждой фото в ячейке
    private lazy var padding: CGFloat = 12
    private lazy var availableWidthForPhotos = UIScreen.main.bounds.width - padding * 2
    private lazy var numberOfPhotos = 4
    private lazy var inset: CGFloat = 8
    private lazy var numberOfInsets = numberOfPhotos - 1
    
    private lazy var photoWidth = CGFloat((Int(availableWidthForPhotos) - numberOfInsets * Int(inset)) / numberOfPhotos)
    
}

// MARK: Layout
private extension PhotosTableViewCell {
    func setupLayout() {
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(photosLabel)
        photosLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }

        contentView.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
            make.centerY.equalTo(photosLabel.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(24)
        }

        contentView.addSubview(firstPhoto)
        firstPhoto.snp.makeConstraints { make in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView.snp.leading).offset(12)
            make.width.equalTo(photoWidth)
            make.height.equalTo(firstPhoto.snp.width)
            make.bottom.equalTo(contentView.snp.bottom).offset(-12)
        }

        contentView.addSubview(secondPhoto)
        secondPhoto.snp.makeConstraints { make in
            make.top.equalTo(firstPhoto.snp.top)
            make.leading.equalTo(firstPhoto.snp.trailing).offset(inset)
            make.width.equalTo(firstPhoto.snp.width)
            make.height.equalTo(firstPhoto.snp.height)
            make.bottom.equalTo(firstPhoto.snp.bottom)
        }

        contentView.addSubview(thirdPhoto)
        thirdPhoto.snp.makeConstraints { make in
            make.top.equalTo(firstPhoto.snp.top)
            make.leading.equalTo(secondPhoto.snp.trailing).offset(inset)
            make.width.equalTo(firstPhoto.snp.width)
            make.height.equalTo(firstPhoto.snp.height)
            make.bottom.equalTo(firstPhoto.snp.bottom)
        }

        contentView.addSubview(fourthPhoto)
        fourthPhoto.snp.makeConstraints { make in
            make.top.equalTo(firstPhoto.snp.top)
            make.leading.equalTo(thirdPhoto.snp.trailing).offset(inset)
            make.width.equalTo(firstPhoto.snp.width)
            make.height.equalTo(firstPhoto.snp.height)
            make.bottom.equalTo(firstPhoto.snp.bottom)
        }
        
    }
    
}

