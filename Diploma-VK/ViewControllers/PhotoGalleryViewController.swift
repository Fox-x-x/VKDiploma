//
//  PhotoViewController.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 28.02.2023.
//

import UIKit
import SnapKit

class PhotoGalleryViewController: UIViewController {
    
    private let topNavigationView = NavigationTopPanelView(
        title: "Фотографии",
        leftButton: .backArrow,
        rightButton: .plus
    )
    
    private let photoSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Все фотографии"
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let photoCountLabel: UILabel = {
        let label = UILabel()
        label.text = "8"
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PhotoGalleryCell.self, forCellWithReuseIdentifier: String(describing: PhotoGalleryCell.self))
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setupLayout()
        
        topNavigationView.onLeftButtonTap = { [weak self] in
            self?.backButtonTap()
        }
        
        topNavigationView.onRightButtonTap = { [weak self] in
            self?.plusButtonTap()
        }
    }
    
    private func setupLayout() {
        view.addSubview(topNavigationView)
        topNavigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(photoSectionLabel)
        photoSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(topNavigationView.snp.bottom).offset(21)
            make.leading.equalTo(topNavigationView.snp.leading).offset(16)
        }
        
        view.addSubview(photoCountLabel)
        photoCountLabel.snp.makeConstraints { make in
            make.top.equalTo(photoSectionLabel.snp.top)
            make.leading.equalTo(photoSectionLabel.snp.trailing).offset(12)
        }
        
        view.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(photoCountLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func plusButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        31
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: PhotoGalleryCell.self),
            for: indexPath) as? PhotoGalleryCell
        else { return UICollectionViewCell() }
        
        cell.photoURL = "beauty"
        
        return cell
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {
    var offset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.bounds.width - offset * 6) / 3
        let height: CGFloat = width * 0.7
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        offset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: .zero, left: offset * 2, bottom: .zero, right: offset * 2)
    }
}
