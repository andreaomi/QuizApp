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
    
    func getQuizzes(completionHandler: @escaping (ResponseModel?) -> Void){
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


struct QuizModel: Codable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let level: Int
    let image: String
    let questions: [QuestionModel]
}

struct QuestionModel: Codable {
    let id: Int
    let question: String
    let answers: [String]
    let correct_answer: Int
}

struct ResponseModel: Codable {
    let quizzes: [QuizModel]
}
