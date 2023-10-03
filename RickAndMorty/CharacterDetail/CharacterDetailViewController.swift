//
//  DetailInfoViewController.swift
//  RickAndMorty
//
//  Created by Ilnur on 01.10.2023.
//

import UIKit
import SnapKit

class CharacterDetailViewController: UIViewController {
    
    
    //MARK: - Properties
    var viewModel: CharacterDetailViewModel? {
        didSet {
            nameLabel.text = viewModel?.name
            spaciesLabel.text = viewModel?.species
            genderLabel.text = viewModel?.gender
            statusLabel.text = viewModel?.status
            
            guard let imageData = viewModel?.imageData else { return }
            mainImageView.image = UIImage(data: imageData)
        }
    }
    
    
    //MARK: - UIConstants
    private enum UIConstants {
        static let cornerRadiusForView: CGFloat = 10.0
        
        static let nameLabelFontSize: CGFloat = 26.0
        static let descriptionLabelFontSize: CGFloat = 17.0
        
        static let subViewToSuperViewInsetOffset: CGFloat = 16.0
        static let mainStackViewSpacing: CGFloat = 30.0
        static let nameLabelHeight: CGFloat = 40.0
        static let mainStackViewHeight: CGFloat = 120
    }
    
    
    //MARK: - DefaultText
    private enum DefaultText: String {
        case unknow = "Unknow"
        case gender = "Gender:"
        case species = "Species:"
        case status = "Status:"
        case favoritesButton = "star.fill"
    }
    
    
    //MARK: - Private properties
    private let mainImageView: UIImageView = {
        let mainImageView = UIImageView()
        mainImageView.isUserInteractionEnabled = false
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = UIConstants.cornerRadiusForView
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.image = UIImage(named: DefaultText.unknow.rawValue)
        return mainImageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: UIConstants.nameLabelFontSize, weight: .bold)
        nameLabel.isUserInteractionEnabled = false
        nameLabel.clipsToBounds = true
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = UIConstants.cornerRadiusForView
        nameLabel.backgroundColor = .backgroundGray
        nameLabel.textColor = .textColor
        nameLabel.text = DefaultText.unknow.rawValue
        return nameLabel
    }()
    
    private let characteristicsView: UIView = {
        let characteristicsView = UIView()
        characteristicsView.backgroundColor = .backgroundGray
        characteristicsView.clipsToBounds = true
        characteristicsView.layer.cornerRadius = UIConstants.cornerRadiusForView
        return characteristicsView
    }()
    
    private let spaciesTextLabel: UILabel = {
        let spaciesTextLabel = UILabel()
        spaciesTextLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        spaciesTextLabel.isUserInteractionEnabled = false
        spaciesTextLabel.textColor = .textColor
        spaciesTextLabel.text = DefaultText.species.rawValue
        return spaciesTextLabel
    }()
    
    private let spaciesLabel: UILabel = {
        let spaciesLabel = UILabel()
        spaciesLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        spaciesLabel.isUserInteractionEnabled = false
        spaciesLabel.textColor = .textColor
        spaciesLabel.text = DefaultText.unknow.rawValue
        return spaciesLabel
    }()
    
    private let genderTextLabel: UILabel = {
        let genderTextLabel = UILabel()
        genderTextLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        genderTextLabel.isUserInteractionEnabled = false
        genderTextLabel.textColor = .textColor
        genderTextLabel.text = DefaultText.gender.rawValue
        return genderTextLabel
    }()
    
    private let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        genderLabel.isUserInteractionEnabled = false
        genderLabel.textColor = .textColor
        genderLabel.text = DefaultText.unknow.rawValue
        return genderLabel
    }()
    
    private let statusTextLabel: UILabel = {
        let statusTextLabel = UILabel()
        statusTextLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        statusTextLabel.isUserInteractionEnabled = false
        statusTextLabel.textColor = .textColor
        statusTextLabel.text = DefaultText.status.rawValue
        return statusTextLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        statusLabel.isUserInteractionEnabled = false
        statusLabel.textColor = .textColor
        statusLabel.text = DefaultText.unknow.rawValue
        return statusLabel
    }()
    
    private let favoriteBarButtonItem: UIBarButtonItem = {
        let favoriteBarButtonItem = UIBarButtonItem()
        favoriteBarButtonItem.image = UIImage(systemName: DefaultText.favoritesButton.rawValue)
        favoriteBarButtonItem.tintColor = .indicatorGray
        return favoriteBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}


//MARK: - Private methods
private extension CharacterDetailViewController {
    
    func configureUI() {
        
        self.view.backgroundColor = .backgroundDarkGray
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = favoriteBarButtonItem

        let mainStackView = UIStackView()
        view.addSubview(mainStackView)
        mainStackView.axis = .vertical
        mainStackView.spacing = UIConstants.mainStackViewSpacing
        mainStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.subViewToSuperViewInsetOffset)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(UIConstants.subViewToSuperViewInsetOffset)
        }
        
        mainStackView.addArrangedSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.height.equalTo(mainImageView.snp.width)
        }
        
        mainStackView.addArrangedSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.nameLabelHeight)
        }
        
        mainStackView.addArrangedSubview(characteristicsView)
        characteristicsView.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.mainStackViewHeight)
        }
        
        let characteristicsStackView = UIStackView()
        characteristicsView.addSubview(characteristicsStackView)
        characteristicsStackView.axis = .vertical
        characteristicsStackView.distribution = .equalSpacing
        characteristicsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.subViewToSuperViewInsetOffset)
        }
        
        let speciesStackView = UIStackView()
        characteristicsStackView.addArrangedSubview(speciesStackView)
        speciesStackView.axis = .horizontal
        speciesStackView.distribution = .equalSpacing
        speciesStackView.addArrangedSubview(spaciesTextLabel)
        speciesStackView.addArrangedSubview(spaciesLabel)
        
        let genderStackView = UIStackView()
        characteristicsStackView.addArrangedSubview(genderStackView)
        genderStackView.axis = .horizontal
        genderStackView.distribution = .equalSpacing
        genderStackView.addArrangedSubview(genderTextLabel)
        genderStackView.addArrangedSubview(genderLabel)
        
        let statusStackView = UIStackView()
        characteristicsStackView.addArrangedSubview(statusStackView)
        genderStackView.axis = .horizontal
        statusStackView.distribution = .equalSpacing
        statusStackView.addArrangedSubview(statusTextLabel)
        statusStackView.addArrangedSubview(statusLabel)
    }
}
