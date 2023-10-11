//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "CharacterCell"
    
    
    //MARK: - Private enums
    private enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }

    private enum UIConstant {
        static let characterImageViewWidth: CGFloat = 100.0
        static let nameLabelHeight: CGFloat = 30.0
        static let statusViewSize: CGFloat = 10.0
        static let statusViewCenterToNameLabelOffset: CGFloat = 20.0
    }
    
    //MARK: - Private properties
    private let characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.backgroundColor = .backgroundDarkGrayColor
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.image = Constant.BackgroundImage.image
        return characterImageView
    }()
    
    private let statusView: UIView = {
        let statusView = UIView()
        statusView.clipsToBounds = true
        statusView.contentMode = .scaleAspectFill
        statusView.backgroundColor = .indicatorGrayColor
        statusView.layer.cornerRadius = UIConstant.statusViewSize / 2
        return statusView
    }()
    
    private let characterNameLabel: UILabel = {
        let characterNameLabel = UILabel()
        characterNameLabel.textColor = .textColor
        characterNameLabel.text = "Unknow"
        characterNameLabel.font = .boldSystemFont(ofSize: Constant.FontSize.nameFontSize)
        return characterNameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .textColor
        statusLabel.text = "Unknow"
        statusLabel.font = .systemFont(ofSize: Constant.FontSize.descriptionFontSize)
        return statusLabel
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImageView.image = nil
        characterNameLabel.text = nil
        statusLabel.text = nil
    }
    
    func configureCell(with character: Character) {
        characterNameLabel.text = character.name
        statusLabel.text = "\(character.status) - \(character.species) - \(character.gender.rawValue)"
        setStatusViewBackgroundColor(status: character.status)
        
        guard let url = URL(string: character.image) else { return }
        characterImageView.kf.setImage(with: url)
    }
}

//MARK: - Private Methods
private extension CharacterCell {

    func configureUI() {
        self.layer.cornerRadius = Constant.CornerRadius.ten
        self.clipsToBounds = true
        self.backgroundColor = .backgroundGrayColor
    }
    
    func addSubviews() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterNameLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(statusLabel)
    }
    
    func makeConstraints() {
        characterImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(UIConstant.characterImageViewWidth)
        }
        
        characterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(characterImageView.snp.trailing).offset(Constant.InsetOffset.eightInsetOffset)
            make.top.trailing.equalToSuperview().inset(Constant.InsetOffset.eightInsetOffset)
            make.height.equalTo(UIConstant.nameLabelHeight)
        }
        
        statusView.snp.makeConstraints { make in
            make.leading.equalTo(characterNameLabel.snp.leading)
            make.width.height.equalTo(UIConstant.statusViewSize)
            make.centerY.equalTo(characterNameLabel.snp.bottom).offset(UIConstant.statusViewCenterToNameLabelOffset)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusView.snp.trailing).offset(Constant.InsetOffset.eightInsetOffset)
            make.trailing.equalToSuperview().inset(Constant.InsetOffset.eightInsetOffset)
            make.centerY.equalTo(characterNameLabel.snp.bottom).offset(UIConstant.statusViewCenterToNameLabelOffset)
        }
    }
    
    func setStatusViewBackgroundColor(status: String) {
        switch status {
        case Status.alive.rawValue:
            statusView.backgroundColor = .indicatorGreen
        case Status.dead.rawValue:
            statusView.backgroundColor = .indicatorRed
        default:
            statusView.backgroundColor = .indicatorGray
        }
    }
}
