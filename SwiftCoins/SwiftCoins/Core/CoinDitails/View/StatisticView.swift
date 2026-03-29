//
//  StatisticView.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/22.
//

import SwiftUI

struct StatisticView: View {
    let model: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Current Price")
                .font(.caption)
            
            Text("$ 27,000.00")
                .font(.headline)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption)
                
                Text("5.2%")
                    .font(.caption)
                    .bold()
                    
            }
            .foregroundColor(.green)
        }
    }
}

//#Preview {
//    StatisticView(model: dev.stat1)
//}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(model: dev.stat1)
    }
}
