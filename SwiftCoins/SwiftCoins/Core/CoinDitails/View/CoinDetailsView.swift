//
//  CoinDetailsView.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/22.
//

import SwiftUI

struct CoinDetailsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
                CoinDetailsSection()
                    .padding(.vertical)
                
                CoinDetailsSection()
                    .padding(.vertical)
                
            }
            .padding()
            .navigationTitle("Bitcoin")
        }
    }
}

#Preview {
    CoinDetailsView()
}
