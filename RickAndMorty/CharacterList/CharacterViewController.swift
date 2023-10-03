//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    
    
    //MARK: - UIConstants
    private enum UIConstants {
        static let cellHeight: CGFloat = 80.0
        static let cellWidthInset = 16.0
        static let fromSuperViewToCollectionViewInset: CGFloat = 16.0
        static let edgeInset: CGFloat = 16.0
        static let minimumLineSpacing: CGFloat = 16.0
    }
    
    
    //MARK: - Private properties
    private var viewModel: CharacterListViewModel! {
        didSet {
            viewModel.fetchPages {
                self.viewModel.fetchCharacters {
                    self.characterCollectionView.reloadData()
                }
            }
        }
    }
    
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
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let characters = ["Rick Sanchez", "Morty Smith"]
        let placeholer = characters.randomElement()
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .acid
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeholer ?? "",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.indicatorGrayColor as Any])
        searchBar.searchTextField.leftView?.tintColor = .acidColor
        searchBar.searchTextField.clearButtonMode = .whileEditing
        searchBar.searchTextField.textColor = .acidColor
        return searchBar
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}


//MARK: - Private methods
private extension CharacterViewController {
    
    func configureUI() {
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.isHidden = false
        navigationItem.titleView = searchBar
        viewModel = CharacterListViewModel()

        characterCollectionView.dataSource = self
        characterCollectionView.delegate = self
        view.addSubview(characterCollectionView)
        characterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


//MARK: - UITableViewDelegate
extension CharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterDetailViewController = CharacterDetailViewController()
        characterDetailViewController.viewModel = viewModel.viewModelForSelectedItem(at: indexPath) as? CharacterDetailViewModel
        navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
}


//MARK: - UITableViewDataSource
extension CharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, 
                                                            for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .backgroundGray
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        
        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension CharacterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.bounds.width - UIConstants.cellWidthInset * 2
        
        return CGSize(width: cellWidth, height: UIConstants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: UIConstants.edgeInset, left: UIConstants.edgeInset, bottom: UIConstants.edgeInset, right: UIConstants.edgeInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstants.minimumLineSpacing
    }
}
