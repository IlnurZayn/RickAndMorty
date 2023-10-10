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
        static let segmentedControlBottomInset: CGFloat = 50.0
        static let segmentedControlSidesInset: CGFloat = 80.0
        static let segmentsTitles = ["All", "Favorites"]
        static let searchBarPlaceholderText = ["Rick Sanchez", "Morty Smith"]
    }
    
    //MARK: - Private properties
    private var viewModel: CharacterListViewModel!
    
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
        searchBar.searchTextField.clearButtonMode = .never
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
    
    //MARK: - Init
    init(viewModel: CharacterListViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addSubviews()
        makeConstaints()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.filterCharacters(showFavoritesOnly: segmentedControl.selectedSegmentIndex == 1, text: searchBar.text ?? "")
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
        
        viewModel.fetchPages {
            self.viewModel.fetchCharacters {
                self.characterCollectionView.reloadData()
            }
        }
    }
    
    func addSubviews() {
        view.addSubview(characterCollectionView)
        view.addSubview(segmentedControl)
    }
    
    func makeConstaints() {
        characterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(UIConstant.segmentedControlBottomInset)
            make.directionalHorizontalEdges.equalToSuperview().inset(UIConstant.segmentedControlSidesInset)
        }
    }
    
    func addTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }

    //MARK: - Objc
    @objc func segmentedControlValueChanged(sender: UISegmentedControl) {
        viewModel.filterCharacters(showFavoritesOnly: segmentedControl.selectedSegmentIndex == 1, text: searchBar.text ?? "")
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.updateCollectionView(forItemAt: indexPath) {
            self.characterCollectionView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource
extension CharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
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
        
        let cellWidth = collectionView.frame.width - Constant.InsetOffset.sixteenInsetOffset * 2
        
        return CGSize(width: cellWidth, height: UIConstant.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constant.InsetOffset.sixteenInsetOffset,
                            left: Constant.InsetOffset.sixteenInsetOffset,
                            bottom: Constant.InsetOffset.sixteenInsetOffset,
                            right: Constant.InsetOffset.sixteenInsetOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.InsetOffset.sixteenInsetOffset
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
