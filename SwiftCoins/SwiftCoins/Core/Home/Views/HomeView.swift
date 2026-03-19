//
//  HomeView.swift
//  SwiftCoins
//
//  Created by 野澤英二郎 on 2026/03/13.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                TopMoversView()
                
                Divider()
                
                AllCoinsView()
            }
            .navigationTitle("Live Prices")
        }
    }
}

#Preview {
    HomeView()
}
