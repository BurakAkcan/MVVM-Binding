//
//  MainViewModel.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 19.09.2023.
//

import Foundation

final class MainViewModel { 
    
    var isLoading: Observable<Bool> = Observable(false)
    var dataSource: Movie?
    var cellDataSource: Observable<[MovieTableCellViewModel]> = Observable(nil)
    
    func getMovie() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        NetworkManager.shared.getTrendingMovies { [weak self] result in
            
            guard let self = self else { return }
            self.isLoading.value = false
            switch result {
            case .success(let data):
                print(data.results.count)
                self.dataSource = data
                self.mapCellData()
            case .failure(let error):
                print(error)
            }
        }
//        let requestHeader: [HTTPHeader] = [HTTPHeader(name: "Authorization", value: "Bearer \(Constants.authToken)")]
//        let request = ServiceRequest(endpoint: .authorization, method: .get, headers: requestHeader)
//        Service.shared.request(request: request) { [weak self] (result: ServiceResult<Movie>) in
//            switch result {
//            case .success(let t):
//                print(t)
//            case .failure(let serviceError):
//                print(serviceError.localizedDescription)
//            }
//        }
    }
    
    func numberOfSection() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    
    func mapCellData() {
        self.cellDataSource.value = dataSource?.results.compactMap({MovieTableCellViewModel(movie: $0)})
    }
    
    func retriveMovie( with id: Int) -> MovieResult? {
        guard let movie = dataSource?.results.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
    
}
