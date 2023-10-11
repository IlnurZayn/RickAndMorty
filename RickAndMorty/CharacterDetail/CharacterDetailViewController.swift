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
            }
            
            setStatusForFavoriteButton()
            
            nameLabel.text = viewModel?.name
            spaciesLabel.text = viewModel?.species
            genderLabel.text = viewModel?.gender
            statusLabel.text = viewModel?.status
            
            if let url = URL(string: viewModel.image) {
                mainImageView.kf.setImage(with: url)
            }
        }
    }
    
    //MARK: - UIConstants
    private enum UIConstants {
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
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = Constant.CornerRadius.ten
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.image = Constant.BackgroundImage.image
        return mainImageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: Constant.FontSize.nameFontSize, weight: .bold)
        nameLabel.clipsToBounds = true
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = Constant.CornerRadius.ten
        nameLabel.backgroundColor = .backgroundGray
        nameLabel.textColor = .textColor
        nameLabel.text = DefaultText.unknow.rawValue
        return nameLabel
    }()
    
    private let characteristicsView: UIView = {
        let characteristicsView = UIView()
        characteristicsView.backgroundColor = .backgroundGray
        characteristicsView.clipsToBounds = true
        characteristicsView.layer.cornerRadius = Constant.CornerRadius.ten
        return characteristicsView
    }()
    
    private let spaciesTextLabel: UILabel = {
        let spaciesTextLabel = UILabel()
        spaciesTextLabel.font = .systemFont(ofSize: Constant.FontSize.descriptionFontSize, weight: .regular)
        spaciesTextLabel.textColor = .textColor
        spaciesTextLabel.text = DefaultText.species.rawValue
        return spaciesTextLabel
    }()
    
    private let spaciesLabel: UILabel = {
        let spaciesLabel = UILabel()
        spaciesLabel.font = .systemFont(ofSize: Constant.FontSize.descriptionFontSize, weight: .regular)
        spaciesLabel.textColor = .textColor
        spaciesLabel.text = DefaultText.unknow.rawValue
        return spaciesLabel
    }()
    
    private let genderTextLabel: UILabel = {
        let genderTextLabel = UILabel()
        genderTextLabel.font = .systemFont(ofSize: Constant.FontSize.descriptionFontSize, weight: .regular)
        genderTextLabel.textColor = .textColor
        genderTextLabel.text = DefaultText.gender.rawValue
        return genderTextLabel
    }()
    
    private let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = .systemFont(ofSize: Constant.FontSize.descriptionFontSize, weight: .regular)
        genderLabel.textColor = .textColor
        genderLabel.text = DefaultText.unknow.rawValue
        return genderLabel
    }()
    
    private let statusTextLabel: UILabel = {
        let statusTextLabel = UILabel()
        statusTextLabel.font = .systemFont(ofSize: Constant.FontSize.descriptionFontSize, weight: .regular)
        statusTextLabel.textColor = .textColor
        statusTextLabel.text = DefaultText.status.rawValue
        return statusTextLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: Constant.FontSize.descriptionFontSize, weight: .regular)
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
    
    private let mainStackView = UIStackView()
    private let characteristicsStackView = UIStackView()
    private let speciesStackView = UIStackView()
    private let genderStackView = UIStackView()
    private let statusStackView = UIStackView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addSubviews()
        addTargets()
        makeConstraints()
    }
}

//MARK: - Private methods
private extension CharacterDetailViewController {
    
    func configureUI() {
        self.view.backgroundColor = .backgroundDarkGray
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = favoriteBarButtonItem
        favoriteBarButtonItem.target = self
        
        configure(for: mainStackView, axis: .vertical, spacing: UIConstants.mainStackViewSpacing)
        configure(for: characteristicsStackView, axis: .vertical)
        configure(for: speciesStackView, statusStackView, genderStackView, axis: .horizontal)
    }
    
    func addSubviews() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(mainImageView)
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(characteristicsView)
        
        characteristicsView.addSubview(characteristicsStackView)
        
        characteristicsStackView.addArrangedSubview(speciesStackView)
        characteristicsStackView.addArrangedSubview(genderStackView)
        characteristicsStackView.addArrangedSubview(statusStackView)
        
        speciesStackView.addArrangedSubview(spaciesTextLabel)
        speciesStackView.addArrangedSubview(spaciesLabel)
        
        genderStackView.addArrangedSubview(genderTextLabel)
        genderStackView.addArrangedSubview(genderLabel)
        
        statusStackView.addArrangedSubview(statusTextLabel)
        statusStackView.addArrangedSubview(statusLabel)
    }
    
    func makeConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constant.InsetOffset.sixteenInsetOffset)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constant.InsetOffset.sixteenInsetOffset)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.height.equalTo(mainImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.nameLabelHeight)
        }
        
        characteristicsView.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.mainStackViewHeight)
        }
        
        characteristicsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constant.InsetOffset.sixteenInsetOffset)
        }
    }
    
    func addTargets() {
        favoriteBarButtonItem.action = #selector(toggleFavorite)
    }

    func configure(for stackViews: UIStackView..., axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0.0) {
        for stackView in stackViews {
            stackView.axis = axis
            stackView.spacing = spacing
            stackView.distribution = .equalSpacing
        }
    }
    
    func setStatusForFavoriteButton() {
        favoriteBarButtonItem.tintColor = viewModel.isFavorite ? .acidColor : .indicatorGrayColor
    }
    
    //MARK: - Objc
    @objc func toggleFavorite() {
        viewModel?.favoriteButtonPressed()
    }
}
