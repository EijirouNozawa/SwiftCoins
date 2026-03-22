//
//  TopMoversItemView.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/13.
//

import SwiftUI
import Kingfisher

struct TopMoversItemView: View {
    let coin: Coin

    var body: some View {
        VStack(alignment: .leading) {
            // Image
           KFImage(URL(string: coin.image))
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.orange)
                .padding(.bottom, 8)
            // Coin info
            HStack(spacing: 2) {
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)

                if let price = coin.currentPrice {
                    Text(String(format: "$%.2f", price))
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("-")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            // Coin percent change
            if let change = coin.priceChangePercentage24H {
                Text("\(change)")
              //  Text(String(format: "%.2f%%", change))
                    .font(.title2)
                    .foregroundColor(change >= 0 ? .green : .red)
            } else {
                Text("-")
                    .font(.title2)
            }
        }
        .frame(width: 140, height: 140)
        .overlay(
            RoundedRectangle(
                cornerRadius: 10
            ).stroke(
                Color(
                    .systemGray4
                ),
                lineWidth: 2
            )
        )
    }
}
