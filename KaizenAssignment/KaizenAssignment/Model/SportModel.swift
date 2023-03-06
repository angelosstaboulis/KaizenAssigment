//
//  SportModel.swift
//  KaizenAssignment
//
//  Created by Angelos Staboulis on 6/3/23.
//

import Foundation
struct SportsModel:Identifiable{
    let id = UUID()
    var title:String
    var date:String
    var subcategories: [SportsModel]?
}
