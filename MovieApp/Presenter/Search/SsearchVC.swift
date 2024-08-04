//
//  SsearchVC.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

import UIKit
import Combine

class SearchVC: UIViewController {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<MovieSection, Movie>
    typealias DataSource = UITableViewDiffableDataSource<MovieSection, Movie>
    
    private lazy var searchView: SearchTableView = {
        let view = SearchTableView()
        return view
    }()
    private lazy var dataSource = makeDataSource()
    private(set) var viewModel: SearchViewModelInterface
    private var disposeBag = Set<AnyCancellable>()
    
    private var searchBar: UISearchBar {
        searchView.searchBar
    }
    
    // MARK: - Init methods
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = searchView
        
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        title = .labels(.search)
        navigationItem.backButtonDisplayMode = .minimal
        setupTableView()
        setUpNavigationItem()
        applyTheme()
        subscribe()
        bind()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.searchTextField.becomeFirstResponder()
    }
    
    //MARK: - bind
    private func bind() {
        viewModel.state
            .eraseToAnyPublisher()
            .receive(on:RunLoop.main)
            .sink(receiveValue:  { [weak self] state in
                self?.updateView(state: state)
            })
            .store(in: &disposeBag)
    }
    
    private func subscribe() {
        viewModel.dataSource
            .removeDuplicates()
            .map { dataSource -> Snapshot in
                var snapShot = Snapshot()
                snapShot.appendSections(MovieSection.allCases)
                snapShot.appendItems(dataSource, toSection: .movies)
                return snapShot
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] snapshot in
                self?.dataSource.apply(snapshot)
                
            })
            .store(in: &disposeBag)
    }
    
    
    //MARK: - setup
    private func setupTableView() {
        searchView.tableView.register(MovieCell.self)
        searchView.tableView.delegate = self
        searchView.tableView.separatorStyle = .none
        searchView.backgroundColor = .clear
        searchBar.delegate = self
        
    }
    
    func setUpNavigationItem() {
        navigationItem.hidesBackButton = true
    }
    
    private func applyTheme() {
        view.backgroundColor = .Design.Primary.background
    }
    
    private func updateView(state: SearchViewModel.State)  {
        switch state {
        case .loading:
            searchView.startLoading()
            
        case .empty:
            viewModel.reset()
            searchView.stopLoading()
            
        case .finished:
            searchView.stopLoading()
            
        case .error:
            searchView.stopLoading()
            viewModel.reset()
            
        default:
            searchView.stopLoading()
            viewModel.reset()
        }
    }
    
}


//MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search.send(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search.send(searchBar.text ?? "")
    }
    
}


//MARK: - UITableViewDelegate
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        viewModel.selection.send(snapshot.itemIdentifiers[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.loadMore(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
}

//MARK: - makeDataSource
extension SearchVC {
    func makeDataSource() -> DataSource {
        return UITableViewDiffableDataSource(
            tableView: searchView.tableView,
            cellProvider: {  tableView, indexPath, movie in
                let cell: MovieCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setModel(model: movie)
                return cell
            }
        )
    }
}



