//
//  Structure.swift
//  QuizApp
//
//  Created by Andrea Omićević on 20/05/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import Foundation

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
