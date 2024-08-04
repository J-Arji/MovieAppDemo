//
//  MovieCell.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

class MovieCell: UITableViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .Design.Body
        label.textColor = .Design.Primary.text
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = .Design.caption
        label.textColor = .Design.Primary.placeholder
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var rightContainerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, releaseDateLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        backgroundColor = .Design.Primary.background
        constructHierarchy()
        activateConstraints()
    }
    
    private func constructHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(rightContainerStackView)
    }
    
    private func activateConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: activateConstraintsForPosterView())
        constraints.append(contentsOf: activateConstraintsForLeftStackView())
        NSLayoutConstraint.activate(constraints)
    }
    
    private func activateConstraintsForPosterView() -> [NSLayoutConstraint] {
        return [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1)
        ]
    }
    
    private func activateConstraintsForLeftStackView() -> [NSLayoutConstraint] {
        return [
            rightContainerStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            rightContainerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            rightContainerStackView.topAnchor.constraint(equalTo: posterImageView.topAnchor,constant: 2),
            rightContainerStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -2),
        ]
    }
    
    // MARK: - Public
    public func setModel(model: Movie) {
        posterImageView.setImage(from: model.poster?.resource(type: .small), placeholder: UIImage(resource: .placeholder))
        nameLabel.text = model.title
        releaseDateLabel.text = model.releaseDate
    }
}
