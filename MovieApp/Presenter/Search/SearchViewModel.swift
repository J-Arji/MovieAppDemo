//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Foundation
import Combine

protocol SearchViewModelInterface {
    typealias ViewState = SearchViewModel.State
    var detailBuilder:  ShowDetailsDelegate?  { get }
    func pushVC(movie: Movie)

    
}


class SearchViewModel {
    //MARK: - properties
    var service: MovieRepository
    weak var detailBuilder: ShowDetailsDelegate?
    public var selection = PassthroughSubject<Movie, Never>()
    public var search = CurrentValueSubject<String, Never>("")
    public var state = CurrentValueSubject<ViewState, Never>(.idle)
    public var dataSource = CurrentValueSubject<[Movie], Never>([])
    private var disposeBag = Set<AnyCancellable>()
    private var hasMorePages: Bool = false
    private var page: Int = 1
    private var searchTask: Task<Void, Error>?
    
    init(service: MovieRepository, detailBuilder: ShowDetailsDelegate) {
        self.service = service
        self.detailBuilder = detailBuilder
        subscribe()
    }
    
    
    private func subscribe() {
        search
            .filter { !$0.isEmpty && $0.count >= 3 }
            .removeDuplicates()
            .debounce(for: .seconds(0.8),scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] query in
                self?.reset()
                self?.fetchShows(with: query)
            })
            .store(in: &disposeBag)
        
        selection
            .sink(receiveValue:  { [unowned self] movie in
                self.pushVC(movie: movie)
            })
            .store(in: &disposeBag)
    }
    
    public func reset() {
        dataSource.send([])
        page = 1
    }
    
    public func addMore() {
        page += 1
    }
    
    deinit {
        reset()
        searchTask?.cancel()
    }
}

extension SearchViewModel {
    //MARK: - Request
    func fetchShows(with query: String) {
        searchTask?.cancel()
        searchTask = Task { @MainActor [weak self] in
            guard let `self` else { return } // Captures self and prevents deinit before task is finished
            self.state.send(.loading)
            do {
                let objct = try await service.search(query: query, page: self.page).toDomain()
                let items = objct.results
                self.state.send(items.isEmpty ? .empty : .finished)
//                self.hasMorePages = objct.hasMorePages
                dataSource.value.append(contentsOf: items)
            } catch {
                print("👔",(error as? DataTransferError)?.description ?? error.localizedDescription)
                self.state.send(.error((error as? DataTransferError)?.description ?? error.localizedDescription))
            }
        }
    }
    
    public func loadMore(index: Int) {
        let isLoading = state.value != .loading
        guard index == dataSource.value.count - 1, isLoading, hasMorePages else { return }
        addMore()
        fetchShows(with: search.value)
    }

}


//MARK: - ShowDetailsDelegate
extension SearchViewModel: SearchViewModelInterface {
    
    func pushVC(movie: Movie) {
        self.detailBuilder?.push(movie: movie)

    }
}


//MARK: - State
extension SearchViewModel {
    enum State: Equatable {
        case idle
        case loading
        case empty
        case finished
        case error(String)
        
        
        static func == (lhs: SearchViewModel.State, rhs: SearchViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle):
                return true
                
            case (.empty, .empty):
                return true
                
            case (.loading, .loading):
                return true
                
            case (.finished, .finished):
                return true
                
            case (.error, .error):
                return true
                
            default:
                return false
            }
            
        }
    }
}
