//
//  SportModel.swift
//  KaizenAssignment
//
//  Created by Angelos Staboulis on 6/3/23.
//

import Foundation
struct SportsModel:Identifiable,Comparable,Hashable{
    static func < (lhs: SportsModel, rhs: SportsModel) -> Bool {
        return lhs.title < rhs.title
    }
    
    let id = UUID()
    var title:String
    var date:String
    var subcategories: [SportsModel]?
}
