//
//  CoinRowView.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/19.
//

import SwiftUI
import Kingfisher

struct CoinRowView: View {
    @StateObject var viewModel: HomeViewModel
    let coin: Coin
    
    var body: some View {
        HStack {
            // market cap rank
            Text("\(coin.marketCapRank.map(String.init) ?? "-") ")
                .font(.caption)
                .foregroundColor(.gray)
            // image
            KFImage(URL(string: coin.image))
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.orange)
            // coin name
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .padding(.leading, 6)
                
            }
            .padding(.leading, 2)
            
            Spacer()
            
            
            // coin price info
            VStack(alignment: .trailing, spacing: 4) {
                if let priceValue = coin.currentPrice {
                    Text(priceValue.toCurrency())
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                } else {
                    Text("-")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                }

                if let change = coin.priceChangePercentage24H {
                    Text(change.toPercentString())
                        .font(.title2)
                        .foregroundColor(change > 0 ? .green : .red)
                } else {
                    Text("-")
                        .font(.title2)
                }
            }
            .padding(.leading, 2)

        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

//#Preview {
//    CoinRowView()
//}
