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
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        view.backgroundColor = .systemBackground
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
        tableView.delegate = self
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
    
    // MARK: - Bind ViewModel
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
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getMovieDetails(movieId: Int) {
        guard let movie = viewModel.retriveMovie(with: movieId) else { return }
        let detailsViewModel = DetailMovieViewModel(movie: movie)
        let detailsController = DetailMovieViewController(viewModel: detailsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
}

// MARK: - TableViewDataSource + Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constant.cellIdentifire, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let cellViewModel = cellDataSource[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        122
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = cellDataSource[indexPath.row].id
        self.getMovieDetails(movieId: movieId)
    }
}
