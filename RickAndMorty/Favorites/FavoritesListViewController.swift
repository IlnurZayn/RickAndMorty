//
//  FavoritesViewController.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit
import SnapKit

class FavoritesListViewController: UIViewController {

    //MARK: - Private properties
    private var characterCollectionView: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.scrollDirection = .vertical
        
        let characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        characterCollectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        characterCollectionView.backgroundColor = .backgroundDarkGrayColor
        characterCollectionView.showsVerticalScrollIndicator = false
        characterCollectionView.showsHorizontalScrollIndicator = false
        return characterCollectionView
    }()
    
    //MARK: - UIConstants
    private enum UIConstant {
        static let itemsPerRows = 2.0
        
        static let itemsEdgeInset: CGFloat = 20.0
        static let minimumLineSpacing: CGFloat = 20.0
        
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

//MARK: - Private methods
private extension FavoritesListViewController {
    
    private func configureUI() {
        
        view.backgroundColor = .backgroundDarkGray
        
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        view.addSubview(characterCollectionView)
        
        characterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension FavoritesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDataSource
extension FavoritesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier,
                                                            for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .backgroundGray
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let peddingWidth = UIConstant.itemsEdgeInset * (UIConstant.itemsPerRows + 1)
        let availibaleWidth = collectionView.frame.width - peddingWidth
        let widthPerItem = availibaleWidth / UIConstant.itemsPerRows

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: UIConstant.itemsEdgeInset, left: UIConstant.itemsEdgeInset, bottom: UIConstant.itemsEdgeInset, right: UIConstant.itemsEdgeInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstant.minimumLineSpacing
    }
}
