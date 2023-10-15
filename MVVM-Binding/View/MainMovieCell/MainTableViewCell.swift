//
//  MainTableViewCell.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 19.09.2023.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    
    public static let identifier = String(describing: MainTableViewCell.self)
    
    public static func register() -> UINib {
        UINib(nibName: "MainTableViewCell", bundle: nil)
    }
    
    // MARK: -IBOutlets

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    // MARK: -Cell Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        configCell()
    }
    
    private func configCell() {
        backView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        backView.layer.borderColor = UIColor.label.cgColor
        backView.layer.borderWidth = 1
        backView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        movieImageView.layer.cornerRadius = 5
    }
    
    func setupCell(viewModel: MovieTableCellViewModel) {
        nameLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        rateLabel.text = viewModel.rating
        movieImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
