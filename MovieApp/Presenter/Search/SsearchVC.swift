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
    
    private lazy var resultView: SearchTableView = {
        let view = SearchTableView()
        return view
    }()
    private lazy var dataSource = makeDataSource()
    private(set) var viewModel: SearchViewModelInterface
    private var disposeBag = Set<AnyCancellable>()
    
    private var searchBar: UISearchBar {
        resultView.searchBar
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
        view = resultView
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        title = "Search"
        navigationItem.backButtonDisplayMode = .minimal
        setupTableView()
        setUpNavigationItem()
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
        resultView.tableView.register(MovieCell.self)
        resultView.tableView.delegate = self
        resultView.tableView.separatorStyle = .none
        searchBar.delegate = self
        
    }
    
    func setUpNavigationItem() {
        navigationItem.hidesBackButton = true
    }
    
    private func updateView(state: SearchViewModel.State)  {
        switch state {
        case .idle:
            viewModel.reset()
            break;
        case .loading:
            break;
            
        case .empty:
            viewModel.reset()
        case .finished:
            break
            
        case .error:
            viewModel.reset()
            break
        }
    }
    
}


//MARK: - UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search.send(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.search.send("")
        viewModel.reset()
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
            tableView: resultView.tableView,
            cellProvider: {  tableView, indexPath, movie in
                let cell: MovieCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.setModel(model: movie)
                return cell
            }
        )
    }
}
//
