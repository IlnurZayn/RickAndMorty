//
//  DetailInfoViewController.swift
//  RickAndMorty
//
//  Created by Ilnur on 01.10.2023.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    var viewModel: CharacterDetailViewModel?
    
    //MARK: - UIConstants
    private enum UIConstants {
        static let nameLabelFontSize: CGFloat = 26.0
        static let descriptionLabelFontSize: CGFloat = 17.0
        static let subViewToViewInset: CGFloat = 16.0
    }
    
    //MARK: - Private properties
    private let mainImageView: UIImageView = {
        let mainImageView = UIImageView()
        mainImageView.isUserInteractionEnabled = false
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.image = UIImage(named: "Unknow")
        return mainImageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: UIConstants.nameLabelFontSize, weight: .bold)
        nameLabel.isUserInteractionEnabled = false
        nameLabel.textColor = .textColor
        nameLabel.text = "Unknow"
        return nameLabel
    }()
    
    private let spaciesLabel: UILabel = {
        let spaciesLabel = UILabel()
        spaciesLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        spaciesLabel.isUserInteractionEnabled = false
        spaciesLabel.textColor = .textColor
        spaciesLabel.text = "Unknow"
        return spaciesLabel
    }()
    
    private let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        genderLabel.isUserInteractionEnabled = false
        genderLabel.textColor = .textColor
        genderLabel.text = "Unknow"
        return genderLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .systemFont(ofSize: UIConstants.descriptionLabelFontSize, weight: .regular)
        statusLabel.isUserInteractionEnabled = false
        statusLabel.textColor = .textColor
        statusLabel.text = "Unknow"
        return statusLabel
    }()
    
    private let favoriteBarButtonItem: UIBarButtonItem = {
        let favoriteBarButtonItem = UIBarButtonItem()
        favoriteBarButtonItem.image = UIImage(systemName: "star.fill")
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
        
        view.addSubview(mainImageView)
        
    }
}
