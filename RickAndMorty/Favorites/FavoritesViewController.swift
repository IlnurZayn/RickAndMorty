//
//  FavoritesViewController.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    
    private var characterCollectionView: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.scrollDirection = .vertical
        
        let characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        characterCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        characterCollectionView.backgroundColor = .backgroundDarkGrayColor
        characterCollectionView.showsVerticalScrollIndicator = false
        characterCollectionView.showsHorizontalScrollIndicator = false
        return characterCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundDarkGray    }
}

//MARK: - Private methods
private extension FavoritesViewController {
    private func configureUI() {
        
        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        view.addSubview(characterCollectionView)
        
        characterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier,
                                                            for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .backgroundGray
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
//extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let cellWidth = collectionView.bounds.width - UIConstants.cellWidthInset * 2
//        
//        return CGSize(width: cellWidth, height: UIConstants.cellHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: UIConstants.edgeInset, left: UIConstants.edgeInset, bottom: UIConstants.edgeInset, right: UIConstants.edgeInset)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return UIConstants.minimumLineSpacing
//    }
//}
