//
//  SportsViewModel.swift
//  KaizenAssignment
//
//  Created by Angelos Staboulis on 6/3/23.
//

import Foundation
import Alamofire
import SwiftyJSON
class SportsViewModel:ObservableObject {
    func convertTimeStampToTime(timeStamp:Double)->String{
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm:SS"
        let strConvertDate = dateFormatter.string(from: date)
        return strConvertDate
    }
    func fetchSports() async -> [SportsModel] {
        let urlPath = "https://618d3aa7fe09aa001744060a.mockapi.io/api/sports"
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        typealias Continuation = CheckedContinuation<[SportsModel], Never>
        let sports = await withCheckedContinuation { (continuation: Continuation) in
            let task = session.dataTask(with: url) { data, response, error in
                var subitems: [SportsModel] = []
                var result: [SportsModel] = []
                defer {
                    continuation.resume(returning: result)
                }
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else {
                    return
                }
                
                do {
                    let jsonResult = try JSON(data: data)
                    for value in 0..<jsonResult.count{
                        for item in  0..<jsonResult[value]["e"].count{
                            let category = jsonResult[value]["i"].stringValue
                            let subcategory = jsonResult[value]["e"][item]["si"].stringValue
                            if category.contains(subcategory)  {                               
                                let strConvertDate = self.convertTimeStampToTime(timeStamp: jsonResult[value]["e"][item]["tt"].doubleValue)
                                subitems.append(SportsModel(title: jsonResult[value]["e"][item]["d"].stringValue, date: strConvertDate, subcategories: nil))

                            }
                        }
                        result.append(SportsModel(title: jsonResult[value]["d"].stringValue, date: "", subcategories: subitems))
                        subitems.removeAll()
                    }
                    
                } catch {
                    print("JSON Error \(error.localizedDescription)")
                    return
                }
            }
            task.resume()
        }
        
        return sports
    }
}
