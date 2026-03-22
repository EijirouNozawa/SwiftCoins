//
//  AllCoinsView.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/19.
//

import SwiftUI

struct AllCoinsView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("All Coins")
                .font(.headline)
                .padding()
            
            HStack {
                Text("Coin")
                
                
                Spacer()
                
                Text("Prices")
                
            }
            .foregroundColor(.gray)
            .font(.caption)
            .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.coins) { coin in
                        CoinRowView(viewModel: viewModel, coin: coin)
                            
                    }
                }
            }
            
            
        }
    }
}

//#Preview {
//    AllCoinsView()
//}
