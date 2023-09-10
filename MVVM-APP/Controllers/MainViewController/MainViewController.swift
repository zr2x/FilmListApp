//
//  MainViewController.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 25.08.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var viewModel = MainViewModel()
    var activityIndicator = UIActivityIndicatorView()
    var cellDataSource = [MovieCellViewModel]()
    let constant = Constant()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        view.backgroundColor = .yellow
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    // MARK: Layout
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: constant.cellIdentifire)
    }
    
    // MARK: Setup ActivityIndicator
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.isHidden = false
        
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.center)
            make.width.height.equalTo(100)
        }
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let strongSelf = self, let movies = movies else { return }
            strongSelf.cellDataSource = movies
            strongSelf.reloadTableView()
        }
    }
}

// MARK: - Extension
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constant.cellIdentifire, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let movie = cellDataSource[indexPath.row]
        cell.textLabel?.text = viewModel.getMoviewTitile(movie)
        return cell
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
