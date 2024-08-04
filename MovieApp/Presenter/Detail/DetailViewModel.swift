//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import Combine

protocol DetailViewModelInterface {
    var movie: CurrentValueSubject<Movie, Never>     { get set }

}

class DetailViewModel: DetailViewModelInterface {
    var movie: CurrentValueSubject<Movie, Never>
    private var disposeBag = Set<AnyCancellable>()

    init(movie: CurrentValueSubject<Movie, Never>) {
        self.movie = movie
    }
    
}
