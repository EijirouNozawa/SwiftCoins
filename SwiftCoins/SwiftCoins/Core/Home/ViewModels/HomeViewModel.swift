//
//  HomeViewModel.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/19.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    init() {
        fetchCoinData()
    }
    
    func fetchCoinData() {
        
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("HTTP Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8) ?? "Unable to convert data to string"
            print("Data fetched successfully: \(dataAsString) bytes")
        }.resume()
            
    }
}
