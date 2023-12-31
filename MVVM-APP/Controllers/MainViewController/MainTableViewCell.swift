//
//  TableViewCell.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 25.08.2023.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    let constant = Constant()
    
    // MARK: - UI 
    private var movieImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.clipsToBounds = false
        return label
    }()
    
    private var desciptionDateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private var rateMovieLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        contentView.addBorder(color: .label, width: 1)
        contentView.round()
        setupViews()
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 13, right: 8))

    }
    
    // MARK: - Views hierarchy
    private func setupViews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(desciptionDateLabel)
        contentView.addSubview(rateMovieLabel)
    }
    
    func setupCell(viewModel: MovieCellViewModel) {
        movieTitleLabel.text = viewModel.title
        desciptionDateLabel.text = viewModel.date
        rateMovieLabel.text = viewModel.rating
        movieImageView.sd_setImage(with: viewModel.imageURL)
    }
    
    
    // MARK: - Layout
    private func setupConstraints() {
        
        movieImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(16)
            make.left.equalTo(contentView).inset(15)
            make.width.height.equalTo(75)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView)
            make.left.equalTo(movieImageView.snp.right).offset(16)
            make.right.equalTo(contentView).inset(8)
        }
        
        desciptionDateLabel.snp.makeConstraints { make in
            make.left.equalTo(movieImageView.snp.right).offset(16)
            make.bottom.equalTo(rateMovieLabel.snp.top).inset(8)
        }
        
        rateMovieLabel.snp.makeConstraints { make in
            make.left.equalTo(movieImageView.snp.right).offset(16)
            make.bottom.equalTo(movieImageView.snp.bottom)
        }
    }
    
    private func setupUI() {
        movieTitleLabel.font = UIFont(name: constant.avenirBlack, size: 15)
        desciptionDateLabel.font = UIFont(name: constant.avenirBook, size: 15)
        rateMovieLabel.font = UIFont(name: constant.avenirBook, size: 15)
    }
}
