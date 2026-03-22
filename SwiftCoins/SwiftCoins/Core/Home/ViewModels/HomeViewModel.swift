//
//  HomeViewModel.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/19.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var topMovingCoins = [Coin]()
    
    init() {
        fetchCoinData()
    }
    
    func fetchCoinData() {
        
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("HTTP Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { return }

            NSLog("[HomeViewModel] Received data size: \(data.count) bytes")
            if let preview = String(data: data.prefix(3000), encoding: .utf8) {
                NSLog("[HomeViewModel] Data preview full: \(preview)")
            }

            // Inspect JSON keys / values on the first element to see if current_price exists and its type
            do {
                let obj = try JSONSerialization.jsonObject(with: data)
                var debugOut = ""
                if let arr = obj as? [[String: Any]], let first = arr.first {
                    if let currentPriceValue = first["current_price"] {
                        let line = "First object's current_price raw: \(type(of: currentPriceValue)) -> \(currentPriceValue)\n"
                        NSLog("[HomeViewModel] First object's current_price raw value: \(type(of: currentPriceValue)) -> \(currentPriceValue)")
                        print("[HomeViewModel] First object's current_price raw value: \(type(of: currentPriceValue)) -> \(currentPriceValue)")
                        debugOut += line
                    } else {
                        let line = "First object has no 'current_price' key\n"
                        NSLog("[HomeViewModel] First object has no 'current_price' key")
                        print("[HomeViewModel] First object has no 'current_price' key")
                        debugOut += line
                    }
                    if let preview = String(data: data.prefix(3000), encoding: .utf8) {
                        debugOut += "DATA_PREVIEW:\n" + preview
                    }
                    // write to temp file for host inspection
                    if let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let url = docs.appendingPathComponent("swiftcoins-json-debug.txt")
                        try? debugOut.write(to: url, atomically: true, encoding: .utf8)
                    }
                 }
             } catch {
                 NSLog("[HomeViewModel] JSONSerialization inspect error: \(error.localizedDescription)")
             }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let coins = try decoder.decode([Coin].self, from: data)
                print("[HomeViewModel] Decoded coins count: \(coins.count)")
                if let first = coins.first {
                    print("[HomeViewModel] First coin: \(first.name) (\(first.symbol)) - price: \(first.currentPrice ?? 0)")
                    NSLog("[HomeViewModel] First coin currentPrice (raw): \(String(describing: first.currentPrice))")
                    // Mirror dump
                    let mirror = Mirror(reflecting: first)
                    for child in mirror.children {
                        if let label = child.label {
                            NSLog("[HomeViewModel] first.\(label) = \(child.value)")
                        }
                    }
                    if let enc = try? JSONEncoder().encode(first), let s = String(data: enc, encoding: .utf8) {
                        NSLog("[HomeViewModel] First coin encoded JSON: \(s)")
                        // write decoded first coin JSON to Documents for inspection
                        if let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                            let url = docs.appendingPathComponent("swiftcoins-decoded-first.json")
                            try? s.write(to: url, atomically: true, encoding: .utf8)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.coins = coins
                    self.configureTopMovingCoins()
                }
            } catch let error as DecodingError {
                print("Decoding error: \(error.localizedDescription)")
                switch error {
                case .typeMismatch(let type, let context):
                    print("Type mismatch for type \(type): \(context.debugDescription) at \(context.codingPath)")
                case .valueNotFound(let type, let context):
                    print("Value not found for type \(type): \(context.debugDescription) at \(context.codingPath)")
                case .keyNotFound(let key, let context):
                    print("Key not found: \(key.stringValue) - \(context.debugDescription) at \(context.codingPath)")
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context.debugDescription)")
                @unknown default:
                    print("Unknown decoding error: \(error)")
                }
            } catch let error {
                print("Error decoding data: \(error.localizedDescription)")
            }
            
        }.resume()
            
    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted(by: { ($0.priceChangePercentage24H ?? 0.0) > ($1.priceChangePercentage24H ?? 0.0) })
        self.topMovingCoins = Array(topMovers.prefix(5))
    }
}
