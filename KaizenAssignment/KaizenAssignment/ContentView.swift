//
//  ContentView.swift
//  KaizenAssignment
//
//  Created by Angelos Staboulis on 4/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SportsViewModel()
    @State var list:[SportsModel] = []
    init(){
        UINavigationBar.appearance().backgroundColor = .green 
    }
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 0) {
                    ForEach(list){ sport in
                        CellRow(sport: sport)
                    }
                }
            }.navigationTitle("KaizenAssignment").navigationBarTitleDisplayMode(.inline)
                .background(Color.blue)
        }.onAppear {
            Task.init {
                list = await viewModel.fetchSports()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
