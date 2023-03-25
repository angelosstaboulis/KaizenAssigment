//
//  CellRow.swift
//  KaizenAssignment
//
//  Created by Angelos Staboulis on 6/3/23.
//

import SwiftUI



struct CellRow: View {
    @State var getSelect:Int!
    @State private var tapped: Bool = false
    @State var sport:SportsModel
    @State var favorite:String!="star"
    @State var star:Bool!=false
    var body: some View {
        VStack(spacing: 0) {
            Text(sport.title)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue)
                .foregroundColor(.white)
                .onTapGesture(perform: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        tapped.toggle()
                    }
                })
            
            if tapped {
                ScrollView(.horizontal){
                    HStack{
                        ForEach(0..<sport.subcategories!.count-1){ item in
                            VStack{
                                HStack{
                                    HStack{
                                        Text(sport.subcategories![item].date)
                                    }
                                }.padding(10)
                                HStack{
                                    if #available(iOS 16.0, *) {
                                        Image(systemName:favorite).onTapGesture {
                                            _ = sport.subcategories?.removeFirst()
                                            sport.subcategories?.insert(sport.subcategories![item-1], at: 0)
                                            sport.subcategories?.sorted()
                                            let first = sport.subcategories?.first
                                            for value in sport.subcategories! {
                                                if value.title.contains(first!.title){
                                                    sport.subcategories?.remove(at: item)
                                                    break
                                                }
                                            }
                                        }
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                                HStack{
                                    Text(sport.subcategories![item].title)
                                    
                                }.padding(10)
                            }
                            
                        }
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all).background(Color.secondary)
    }
}

struct CellRow_Previews: PreviewProvider {
    static var previews: some View {
        CellRow(sport: SportsModel(title: "", date: ""))
    }
}
