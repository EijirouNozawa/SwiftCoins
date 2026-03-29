//
//  PreviewProvider.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/22.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    let stat1 = StatisticModel(
        title: "Current Price",
        value: "$21,543,00",
        percentageChange: 1.12
    )
    
    let stat2 = StatisticModel(
        title: "Market Capotalization",
        value: "$412,158n",
        percentageChange: 1.67
    )

    
    let stat3 = StatisticModel(
        title: "Rank",
        value: "1",
        percentageChange: nil
    )

    
    let stat4 = StatisticModel(
        title: "Volume",
        value: "$35,998n",
        percentageChange: nil
    )

}
