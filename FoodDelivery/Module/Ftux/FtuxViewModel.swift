//
//  FtuxViewModel.swift
//  FoodDelivery
//
//  Created by Ciko Edo Febrian on 15/04/24.
//

import Foundation


class FtuxViewModel {
    var ftuxes: [FtuxModel] = []
    let error: FDObservable<Error?> = FDObservable<Error?>(nil)
    let currentIndex : FDObservable<Int> = FDObservable(-1)
    
    func loadFtuxes() {
        FtuxProvider.shared.loadFtux { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.ftuxes = result
                self.currentIndex.value = result.count > 0 ? 0 : -1
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    var numberOfItems: Int {
        return ftuxes.count
    }
}
