//
//  DetailVC.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit
import Combine

class DetailVC: UIViewController {
    //MARK: -
    var viewModel: DetailViewModelInterface
    private var disposeBag = Set<AnyCancellable>()
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.lineBreakMode = .byWordWrapping
        //    label.font = UIFont.app_title3().bolded
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
    // MARK: - Init methods
    init(viewModel: DetailViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionLabel.sizeToFit()
    }
    
    //MARK: - setup UI
    private func setupUI() {
        self.view.backgroundColor = .secondarySystemBackground
        constructHierarchy()
        activateConstraints()
    }
    private func constructHierarchy() {
        self.view.addSubview(coverImageView)
        self.view.addSubview(descriptionLabel)
    }
    private func activateConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: activateConstraintsForImageView())
        constraints.append(contentsOf: activateConstraintsForLabel())
        NSLayoutConstraint.activate(constraints)
    }
    private func activateConstraintsForImageView() -> [NSLayoutConstraint] {
        return [
            coverImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            coverImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ]
    }
    private func activateConstraintsForLabel() -> [NSLayoutConstraint] {
        return [
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ]
    }
    
    
    //MARK: - bind viewModel
    private func bind() {
        viewModel.movie
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .sink { [weak self] movie in
                self?.coverImageView.setImage(from: movie.cover?.resource(type: .original), placeholder: UIImage(resource: .placeholder))
                self?.descriptionLabel.text = movie.overview
                self?.title = movie.title
            }
            .store(in: &disposeBag)
    }
}
