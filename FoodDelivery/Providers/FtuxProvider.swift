//
//  FtuxProvider.swift
//  FoodDelivery
//
//  Created by Ciko Edo Febrian on 05/03/24.
//

import Foundation


class FtuxProvider {
    static let shared = FtuxProvider()
    private init () {}
    
    func loadFtux(completion: @escaping (Result<[FtuxModel], Error>) -> Void) {
        let data = [
            FtuxModel(title: "Find Food You Love", subtitle: "Discover the best food from over 1,000 restaurants and fast delivery to your doorstep", image:  "img_ftux_1"),
            FtuxModel(title: "Fast Delivery", subtitle: "Fast food delivery to your home, office, whenever you are", image:  "img_ftux_2"),
            FtuxModel(title: "Live Tracking", subtitle: "Real time tracking of your food on the app once you placed the order", image:  "img_ftux_3")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(data))
        }
        
    }
}

