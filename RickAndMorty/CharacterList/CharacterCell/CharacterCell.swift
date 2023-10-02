//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit
import SnapKit

class CharacterCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "CharacterCell"
    var viewModel: CharacterCellViewModelProtocol! {
        didSet {
            characterNameLabel.text = viewModel.name
            statusLabel.text = viewModel.fullStatus
            guard let imageData = viewModel.imageData else { return }
            characterImageView.image = UIImage(data: imageData) ?? UIImage(named: "Unknow")
        }
    }
    
    //MARK: - UIConstants
    private enum UIConstants {
        static let nameLabelFontSize: CGFloat = 26.0
        static let statusLabelFontSize: CGFloat = 17.0
        static let characterImageViewWidth: CGFloat = 100.0
        static let cornerRadiusSize: CGFloat = 10.0
        static let imageToLabelOffset: CGFloat = 10.0
        static let nameLabelInset: CGFloat = 10.0
        static let nameLabelHeight: CGFloat = 30.0
        static let statusViewCenterToNameLabelOffset: CGFloat = 20.0
        static let statusViewToStatusLabelOffset: CGFloat = 10.0
        static let statusStackInset: CGFloat = 10.0
        static let statucLabelToNameLabeelOffset: CGFloat = 5.0
        static let statusViewSize: CGFloat = 10.0
        static let statusViewInset: CGFloat = 10.0
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
    
    private let statusView: UIView = {
        let statusView = UIView()
        statusView.isUserInteractionEnabled = false
        statusView.clipsToBounds = true
        statusView.contentMode = .scaleAspectFill
        statusView.backgroundColor = .indicatorGrayColor
        statusView.layer.cornerRadius = UIConstants.statusViewSize / 2
        return statusView
    }()
    
    private let characterNameLabel: UILabel = {
        let characterNameLabel = UILabel()
        characterNameLabel.isUserInteractionEnabled = false
        characterNameLabel.textColor = .textColor
        characterNameLabel.text = "Unknow"
        characterNameLabel.font = .boldSystemFont(ofSize: UIConstants.nameLabelFontSize)
        return characterNameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.isUserInteractionEnabled = false
        statusLabel.textColor = .textColor
        statusLabel.text = "Unknow"
        statusLabel.font = .systemFont(ofSize: UIConstants.statusLabelFontSize)
        return statusLabel
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

//MARK: - Private Methods
private extension CharacterCell {

    func configureUI() {
        
        self.layer.cornerRadius = UIConstants.cornerRadiusSize
        self.clipsToBounds = true
        
        contentView.addSubview(characterImageView)
        characterImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(UIConstants.characterImageViewWidth)
        }
        
        contentView.addSubview(characterNameLabel)
        characterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView.snp.trailing).offset(UIConstants.imageToLabelOffset)
            make.top.trailing.equalToSuperview().inset(UIConstants.nameLabelInset)
            make.height.equalTo(UIConstants.nameLabelHeight)
        }
        
        contentView.addSubview(statusView)
        statusView.snp.makeConstraints { make in
            make.leading.equalTo(characterNameLabel.snp.leading)
            make.width.height.equalTo(UIConstants.statusViewSize)
            make.centerY.equalTo(characterNameLabel.snp.bottom).offset(UIConstants.statusViewCenterToNameLabelOffset)
        }
        
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusView.snp.trailing).offset(UIConstants.statusViewToStatusLabelOffset)
            make.centerY.equalTo(characterNameLabel.snp.bottom).offset(UIConstants.statusViewCenterToNameLabelOffset)
        }
    }
}
