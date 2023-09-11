//
//  DetailMovieViewController.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 11.09.2023.
//

import SDWebImage
import UIKit

class DetailMovieViewController: UIViewController {
    
    var viewModel: DetailMovieViewModel
    let constant = Constant()
    
    // MARK: - UI
    private var movieImageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: constant.avenirBlack, size: 20)
        return label
    }()
    
    private lazy var descriptionMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: constant.avenirBook, size: 15)
        return label
    }()
    
    init(viewModel: DetailMovieViewModel) {
        self.viewModel = viewModel
//        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
        configureView()
    }
    
    // MARK: - Views hierarchy
    private func setupViews() {
        view.addSubview(movieImageView)
        view.addSubview(movieTitleLabel)
        view.addSubview(descriptionMovieLabel)
    }
    
    // MARK: - Layout
    private func setupConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(15)
            make.left.right.equalTo(view).inset(8)
            make.width.height.equalTo(200)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(8)
            make.top.equalTo(movieImageView.snp.bottom).inset(20)
        }
        
        descriptionMovieLabel.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(8)
            make.top.equalTo(movieTitleLabel.snp.bottom).inset(20)
        }
    }
    
    private func configureView() {
        self.title = "Movie description"
        movieTitleLabel.text = viewModel.movieTitle
        movieImageView.sd_setImage(with: viewModel.movieImage)
        descriptionMovieLabel.text = viewModel.movieDescription
    }
}
