//
//  AllCoinsView.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/19.
//

import SwiftUI

struct AllCoinsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("All Cooins")
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
                    ForEach(0 ..< 50, id: \.self) { _ in
                        CoinRowView()
                    }
                }
            }
            
            
        }
    }
}

#Preview {
    AllCoinsView()
}
