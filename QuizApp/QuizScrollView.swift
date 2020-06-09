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
    
    
    var contentWidth: CGFloat = 0.0
    
    //var questionsStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .red
        //self.delegate = self
        //buildView()
        //makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        //setUpQuestionView(quizModel: quizModel)
        //buildView()
        //makeConstraints()
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpQuestionView(quizModel: QuizModel?){
        self.quizModel = quizModel
        guard let numberOfQuestions = self.quizModel?.questions.count else {return}
        
        //questionsStackView.axis = .horizontal
        //questionsStackView.distribution = .fillEqually
               
        for i in 0..<numberOfQuestions{
            questionView = QuestionView()
            addSubview(questionView)
            //questionView.autoPinEdge(toSuperviewEdge: .top, with)
            
            let xCordinate = self.frame.minX + self.frame.width * CGFloat(i)
            contentWidth += self.frame.width
    
            print(self.frame.width)
            //questionView
            questionView.frame = CGRect(x: xCordinate, y: self.frame.minY, width: 100, height: 100)
            addSubview(questionView)
                
            //questionsStackView.addArrangedSubview(questionView)
            questionView.setQuestion(questionModel: (quizModel?.questions[i])!)
            //addSubview(questionView)
            //questionView.autoMatch(.width, to: .width, of: self)
            print("tu")
            }
        
        //self.contentSize = CGSize(width: contentWidth, height: self.frame.height)
        //questionsStackView.distribution = .fillEqually
        //addSubview(questionsStackView)
        //questionsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        //questionsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        //questionsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        //questionsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        
    }
  
    
    
    
    

}
