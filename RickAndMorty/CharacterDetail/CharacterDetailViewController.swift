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
    var viewModel: CharacterDetailViewModel! {
        didSet {
            viewModel.viewModelDidChange = { [unowned self] viewModel in
                setStatusForFavoriteButton()
                viewModel.deleteCharacter(forFalse: viewModel.isFavorite)
            }
            
            setStatusForFavoriteButton()
            
            nameLabel.text = viewModel?.name
            spaciesLabel.text = viewModel?.species
            genderLabel.text = viewModel?.gender
            statusLabel.text = viewModel?.status
            
            viewModel.fetchImage { data in
                guard let data = data else { return }
                self.mainImageView.image = UIImage(data: data)
            }
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
    private lazy var mainImageView: UIImageView = {
        let mainImageView = UIImageView()
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = UIConstants.cornerRadiusForView
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.image = UIImage(named: DefaultText.unknow.rawValue)
        return mainImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: UIConstants.nameLabelFontSize, weight: .bold)
        nameLabel.clipsToBounds = true
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = UIConstants.cornerRadiusForView
        nameLabel.backgroundColor = .backgroundGray
        nameLabel.textColor = .textColor
        nameLabel.text = DefaultText.unknow.rawValue
        return nameLabel
    }()
    
    private lazy var characteristicsView: UIView = {
        let characteristicsView = UIView()
        characteristicsView.backgroundColor = .backgroundGray
        characteristicsView.clipsToBounds = true
        characteristicsView.layer.cornerRadius = UIConstants.cornerRadiusForView
        return characteristicsView
    }()
    
    private lazy var spaciesTextLabel: UILabel = {
        let spaciesTextLabel = UILabel()
        spaciesTextLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        spaciesTextLabel.textColor = .textColor
        spaciesTextLabel.text = DefaultText.species.rawValue
        return spaciesTextLabel
    }()
    
    private lazy var spaciesLabel: UILabel = {
        let spaciesLabel = UILabel()
        spaciesLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        spaciesLabel.textColor = .textColor
        spaciesLabel.text = DefaultText.unknow.rawValue
        return spaciesLabel
    }()
    
    private lazy var genderTextLabel: UILabel = {
        let genderTextLabel = UILabel()
        genderTextLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        genderTextLabel.textColor = .textColor
        genderTextLabel.text = DefaultText.gender.rawValue
        return genderTextLabel
    }()
    
    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        genderLabel.textColor = .textColor
        genderLabel.text = DefaultText.unknow.rawValue
        return genderLabel
    }()
    
    private lazy var statusTextLabel: UILabel = {
        let statusTextLabel = UILabel()
        statusTextLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        statusTextLabel.textColor = .textColor
        statusTextLabel.text = DefaultText.status.rawValue
        return statusTextLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        statusLabel.textColor = .textColor
        statusLabel.text = DefaultText.unknow.rawValue
        return statusLabel
    }()
    
    private lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let favoriteBarButtonItem = UIBarButtonItem()
        favoriteBarButtonItem.image = UIImage(systemName: DefaultText.favoritesButton.rawValue)
        favoriteBarButtonItem.action = #selector(toggleFavorite)
        favoriteBarButtonItem.tintColor = .indicatorGray
        return favoriteBarButtonItem
    }()
    
    //MARK: - Lifecycle
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
        favoriteBarButtonItem.target = self

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
        
        let speciesStackView = UIStackView() // убрать повторения
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
    
    func createStack() -> UIStackView {
        return UIStackView()
    }
    
    func setStatusForFavoriteButton() {
        favoriteBarButtonItem.tintColor = viewModel.isFavorite ? .acidColor : .indicatorGrayColor
    }
    
    //MARK: - Objc
    @objc func toggleFavorite() {
        viewModel?.favoriteButtonPressed()
    }
}
