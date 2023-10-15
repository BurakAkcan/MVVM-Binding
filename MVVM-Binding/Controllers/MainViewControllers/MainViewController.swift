//
//  MainViewController.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 19.09.2023.
//

import UIKit
import Alamofire

final class MainViewController: UIViewController {
    
    // MARK: -Properties
     lazy var viewModel = MainViewModel()

    // MARK: -Outputs
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: -Variables
    var cellDataSource: [MovieTableCellViewModel] = []
    
    // MARK: -View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getMovie()
    }

    // MARK: -Methods
    private func configView() {
        title = "Movie List"
        setTableView()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self,
                  let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.loadingIndicator.startAnimating()
                }else {
                    self.loadingIndicator.stopAnimating()
                }
            }
            
        }
        viewModel.cellDataSource.bind { [weak self] movies in
            
            guard let self = self,
                  let movies = movies else { return }
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
    
    func openDetail(movieId: Int) {
        guard let movie = viewModel.retriveMovie(with: movieId) else {
            return
        }
        let detailViewModel = DetailViewModel(movie: movie)
        let detailController = DetailsMovieViewController(detailViewModel: detailViewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailController, animated: true)
        }
        
    }
}

