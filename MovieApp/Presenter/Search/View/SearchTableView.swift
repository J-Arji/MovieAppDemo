//
//  SearchTableView.swift
//  MovieApp
//
//  Created by javad Arji on 8/4/24.
//

import UIKit

class SearchTableView: UIView {
    //MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        var view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    // MARK: - Private
    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        constructHierarchy()
        activateConstraints()
        configureTableView()
        configureSearchBar()
    }
    
    private func constructHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
    }
    
    private func activateConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: activateConstraintsForTableView())
        constraints.append(contentsOf: activateConstraintsForSearchBar())
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .systemBackground
    }
    
    private func activateConstraintsForTableView() -> [NSLayoutConstraint] {
        return [
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }
    
    private func activateConstraintsForSearchBar() -> [NSLayoutConstraint] {
        return [
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ]
    }
}
