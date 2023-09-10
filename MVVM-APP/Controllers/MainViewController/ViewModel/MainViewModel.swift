//
//  MainViewModel.swift
//  MVVM-APP
//
//  Created by Искандер Ситдиков on 25.08.2023.
//

import Foundation

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
        self.cellDataSource.value = dataSource?.results ?? []
    }
    
    func getMoviewTitile(_ movie: Movie) -> String {
        return movie.title ?? movie.name ?? ""
    }
}
