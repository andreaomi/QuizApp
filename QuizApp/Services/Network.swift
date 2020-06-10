//
//  Network.swift
//  QuizApp
//
//  Created by Andrea Omićević on 10/05/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import Foundation

class Network {
    
    private let apiString = "https://iosquiz.herokuapp.com/api/quizzes"
    private let session = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func getQuizzes(completionHandler: @escaping (ResponseModel?) -> Void) -> Void{
        guard let url = URL(string: apiString) else {return}
        let task = session.dataTask(with: url) { (data, _, error) in
            if error != nil {
                print("Došlo je do pogreške!")
                completionHandler(nil)
                return
            }
            
            guard let jsonData = data else {return}
            
            do{
                let response = try self.jsonDecoder.decode(ResponseModel.self, from: jsonData)
                completionHandler(response)
            }catch{
                print("Pogreška")
                completionHandler(nil)
                return
            }
            
        }
        
        task.resume()
        
    }
    
}


