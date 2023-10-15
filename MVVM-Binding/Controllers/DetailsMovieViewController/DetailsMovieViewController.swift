//
//  DetailsMovieViewController.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 9.10.2023.
//

import UIKit

// MARK: -Class
final class DetailsMovieViewController: UIViewController {
    
    // MARK: -Outputs
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
     
    // MARK: -Variables
     var detailViewModel: DetailViewModel
    
    init(detailViewModel: DetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: "DetailsMovieViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    // MARK: -Actions
    private func configView() {
        imageView.layer.cornerRadius = 4
        self.title = "MovieDetail"
        titleLabel.text = detailViewModel.movieTitle
        detailLabel.text = detailViewModel.movieDescription
        imageView.sd_setImage(with: detailViewModel.moviewImage)
    }
}

// MARK: -Extensions
