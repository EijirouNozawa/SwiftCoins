//
//  CoinDetailsSection.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/22.
//

import SwiftUI

struct CoinDetailsSection: View {
    
    let stat1 = StatisticModel(
        title: "Current Price",
        value: "$21,543,00",
        percentageChange: 1.12
    )
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("Overview")
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(0 ..< 4, id: \.self) { index in
                    StatisticView(model: stat1)
                }
            }
                    
        }
    }
}

#Preview {
    CoinDetailsSection()
}
