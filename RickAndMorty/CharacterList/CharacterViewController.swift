//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Ilnur on 30.09.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    
    //MARK: - UIConstants
    private enum UIConstant {
        static let cellHeight: CGFloat = 80.0
        static let cellWidthInset = 16.0
        static let fromSuperViewToCollectionViewInset: CGFloat = 16.0
        static let itemsEdgeInset: CGFloat = 16.0
        static let minimumLineSpacing: CGFloat = 16.0
        static let segmentedControlBottomInset: CGFloat = 50.0
        static let segmentedControlSidesInset: CGFloat = 80.0
        static let segmentsTitles = ["All", "Favorites"]
        static let searchBarPlaceholderText = ["Rick Sanchez", "Morty Smith"]
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
    
    private let characterCollectionView: UICollectionView = {
        let loyaut = UICollectionViewFlowLayout()
        loyaut.scrollDirection = .vertical
        
        let characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: loyaut)
        characterCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        characterCollectionView.backgroundColor = .backgroundDarkGrayColor
        characterCollectionView.showsVerticalScrollIndicator = false
        return characterCollectionView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let placeholder = UIConstant.searchBarPlaceholderText.randomElement()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.indicatorGrayColor as Any])
        searchBar.tintColor = .acidColor
        searchBar.searchTextField.leftView?.tintColor = .acidColor
        searchBar.searchTextField.textColor = .acidColor
        searchBar.searchTextField.clearButtonMode = .whileEditing
        searchBar.showsCancelButton = true
        
        return searchBar
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: UIConstant.segmentsTitles)
        segmentedControl.backgroundColor = .backgroundGrayColor
        segmentedControl.selectedSegmentTintColor = .acidColor
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderColor = UIColor.backgroundDarkGrayColor?.cgColor
        segmentedControl.layer.borderWidth = 1.0
        return segmentedControl
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        makeConstaints()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.filterCharacters(showFavoritesOnly: selectedFavoritesSegment(), text: searchBar.text ?? "")
        characterCollectionView.reloadData()
    }
}

//MARK: - Private methods
private extension CharacterViewController {
    
    func configureUI() {
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.isHidden = false
        navigationItem.titleView = searchBar
        characterCollectionView.subscribe(self)
        searchBar.delegate = self
        
        viewModel = CharacterListViewModel()

        view.addSubview(characterCollectionView)
        view.addSubview(segmentedControl)
    }
    
    func makeConstaints() {
        characterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIConstant.segmentedControlBottomInset)
            make.leading.trailing.equalToSuperview().inset(UIConstant.segmentedControlSidesInset)
        }
    }
    
    func addTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    func selectedFavoritesSegment() -> Bool {  //remove
        segmentedControl.selectedSegmentIndex == 1
    }
    
    //MARK: - Objc
    @objc func segmentedControlValueChanged(sender: UISegmentedControl) {
        viewModel.filterCharacters(showFavoritesOnly: selectedFavoritesSegment(), text: searchBar.text ?? "")
        characterCollectionView.reloadData()
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
        
        let character = viewModel.currentCell(at: indexPath)
        cell.configureCell(with: character)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CharacterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width - UIConstant.cellWidthInset * 2
        
        return CGSize(width: cellWidth, height: UIConstant.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: UIConstant.itemsEdgeInset, left: UIConstant.itemsEdgeInset, bottom: UIConstant.itemsEdgeInset, right: UIConstant.itemsEdgeInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIConstant.minimumLineSpacing
    }
}

//MARK: - UISearchBarDelegate
extension CharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.search(by: "")
        characterCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.search(by: "")
        characterCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(by: searchText)
        characterCollectionView.reloadData()
    }
}
