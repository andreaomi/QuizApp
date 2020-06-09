//
//  QuizScrollView.swift
//  QuizApp
//
//  Created by Andrea Omićević on 07/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class QuizScrollView: UIScrollView{
    
    var questionView : QuestionView!

    var quizModel : QuizModel?
    
    var questionsStackView = UIStackView()
    
    var scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        scrollView.backgroundColor = .red
        setUpQuestionView(quizModel: quizModel)
        //self.delegate = self
        //buildView()
        //makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        //setUpQuestionView(quizModel: quizModel)
        //buildView()
        //makeConstraints()
        print(self.frame.size.width)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpQuestionView(quizModel: QuizModel?){
        self.quizModel = quizModel
        guard let numberOfQuestions = self.quizModel?.questions.count else {return}
        
        questionsStackView.axis = .horizontal
        questionsStackView.distribution = .fillEqually
               
        for i in 0..<numberOfQuestions{
            questionView = QuestionView()
            questionView.setQuestion(questionModel: (quizModel?.questions[i])!)
            questionView.autoMatch(.width, to: .width, of: self)
            questionsStackView.addArrangedSubview(questionView)
            print("tu")
            }
        
        scrollView.addSubview(questionsStackView)
        addSubview(scrollView)
        scrollView.autoMatch(.width, to: .width, of: self)
        /*questionsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        questionsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        questionsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        questionsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        scrollView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        scrollView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        scrollView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        scrollView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        */
        
    }
  
    
    
    
    

}
