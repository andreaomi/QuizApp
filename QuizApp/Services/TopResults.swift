//
//  TopResults.swift
//  QuizApp
//
//  Created by Andrea Omićević on 20/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import Foundation


class TopResultsServices{
    
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func getTopResults(_ quizId: Int, completionHandler: @escaping ([Results]?)-> Void)-> Void{
        let apiString = "https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizId)"
        
        guard let url = URL(string: apiString) else {return}
        let request = NSMutableURLRequest(url: url)
        
        let token = UserDefaults.standard.value(forKey: "accessToken")!
        //print(token)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Došlo je do pogreške!")
                completionHandler(nil)
                return
            }
            
            guard let jsonData = data else {return }
            
            
            do {
                let response = try self.jsonDecoder.decode([Results].self, from: jsonData)
                completionHandler(response)
                
            } catch {
                print("Pogreška")
                completionHandler(nil)
                return
                
            }
        }
        task.resume()
    }
    
}

struct Results: Codable{
    let username: String
    let score: String?
    
}
