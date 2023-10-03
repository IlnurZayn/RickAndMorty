//
//  FavoriteCell.swift
//  RickAndMorty
//
//  Created by Ilnur on 03.10.2023.
//

import UIKit
import SnapKit

class FavoriteCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCell"
    
    //MARK: - UIConstants
    private enum UIConstant {
        static let cornerRadiusSize = 10.0
        static let nameLabelFontSize: CGFloat = 17.0
        static let favoriteButtonToImageViewInset: CGFloat = 5.0
        static let favoriteButtonSize: CGFloat = 30.0
    }
    
    //MARK: - Private properties
    private let characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.backgroundColor = .backgroundDarkGrayColor
        characterImageView.isUserInteractionEnabled = false
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.image = UIImage(named: "Unknow")
        return characterImageView
    }()
    
    private let favoriteButton: UIButton = {
        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoriteButton.tintColor = .acid
        return favoriteButton
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension FavoriteCell {
    
    func configureUI() {
        
        self.layer.cornerRadius = UIConstant.cornerRadiusSize
        self.clipsToBounds = true
        
        contentView.addSubview(characterImageView)
        characterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(characterImageView.snp.width)
        }
        
        contentView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(UIConstant.favoriteButtonToImageViewInset)
            make.width.height.equalTo(UIConstant.favoriteButtonSize)
        }
    }
}
