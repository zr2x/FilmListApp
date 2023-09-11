//
//  MainViewModel.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 25.08.2023.
//

import Foundation

//protocol MainViewModelProtocol {
//    var issLoading: T { get set }
//    var dataSource: TrendingMovieModel? { get set }
//    
//    
//    associatedtype: T
//}

class MainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var dataSource: TrendingMovieModel?
    var cellDataSource: Observable<[MovieCellViewModel]> = Observable<[MovieCellViewModel]>([])
    
    func numberOfSections() -> Int {
        1
    }
    
    func numbersOfRows(in section: Int) -> Int {
        dataSource?.results.count ?? 0
    }
    
    func getData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        ApiCaller.getTrendingMovies { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.results.compactMap({ MovieCellViewModel(movie: $0) })
    }
    
    func getMoviewTitile(_ movie: Movie) -> String {
        return movie.title ?? movie.name ?? ""
    }
    
    func retriveMovie(with id: Int) -> Movie? {
        guard let movie = dataSource?.results.first(where: { $0.id == id }) else { return nil }
        
        return movie
    }
}
