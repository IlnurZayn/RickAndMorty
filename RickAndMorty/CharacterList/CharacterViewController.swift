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
        static let segmentedControlBottomInset: CGFloat = 25.0
        static let segmentedControlSidesInset: CGFloat = 80.0
        static let segmentsTitles = ["All", "Favorites"]
        static let searchBarPlaceholderText = ["Rick Sanchez", "Morty Smith"]
    }
    
    //MARK: - Private properties
    private var viewModel: CharacterListViewModel!
    
    private let characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let characterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        makeConstraints()
        addTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.filterCharacters(text: searchBar.text ?? "")
        characterCollectionView.reloadData()
    }
}

//MARK: - Private methods
private extension CharacterViewController {
    
    func configureUI() {
        navigationItem.backButtonTitle = ""
        navigationItem.titleView = searchBar
        
        characterCollectionView.subscribe(self)
        searchBar.delegate = self
        
        viewModel.fetchPagesCount()
        
        self.viewModel.fetchCharacters { [weak self] in
            guard let self else { return }
            self.characterCollectionView.reloadData()
        }
    }
    
    func addSubviews() {
        view.addSubview(characterCollectionView)
        view.addSubview(segmentedControl)
    }
    
    func makeConstraints() {
        characterCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.bottomMargin.equalToSuperview().inset(UIConstant.segmentedControlBottomInset)
            make.directionalHorizontalEdges.equalToSuperview().inset(UIConstant.segmentedControlSidesInset)
        }
    }
    
    func addTargets() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }

    //MARK: - Objc
    @objc func segmentedControlValueChanged(sender: UISegmentedControl) {
        guard let searchText = searchBar.text else { return }
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.isFavorites = false
            viewModel.filterCharacters(text: searchText)
        case 1:
            viewModel.isFavorites = true
            viewModel.filterCharacters(text: searchText)
        default:
            break
        }
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
        viewModel.loadNextPage(for: indexPath) { [weak self] in
            guard let self else { return }
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
        
        let cellWidth = collectionView.frame.width - Constant.InsetOffset.l * 2
        
        return CGSize(width: cellWidth, height: UIConstant.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constant.InsetOffset.l,
                            left: Constant.InsetOffset.l,
                            bottom: Constant.InsetOffset.l,
                            right: Constant.InsetOffset.l)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.InsetOffset.l
    }
}

//MARK: - UISearchBarDelegate
extension CharacterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filterCharacters(text: "")
        characterCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filterCharacters(text: "")
        characterCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCharacters(text: searchText)
        characterCollectionView.reloadData()
    }
}
