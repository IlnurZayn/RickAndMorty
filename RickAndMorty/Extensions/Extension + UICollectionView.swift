//
//  Extension + UICollectionView.swift
//  RickAndMorty
//
//  Created by Ilnur on 04.10.2023.
//

import UIKit

extension UICollectionView {
    func subscribe(_ object: (UICollectionViewDelegate & UICollectionViewDataSource)) {
        delegate = object
        dataSource = object
    }
}
