//
//  QuizScrollView.swift
//  QuizApp
//
//  Created by Andrea Omićević on 07/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class QuizScrollView: UIScrollView {
    
    var questionView : QuestionView!

    var quizModel : QuizModel?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .red
        buildView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buildView(){
        questionView = QuestionView()
        addSubview(questionView)
        
    }
    
    
    func setUpQuestionView(quizModel: QuizModel?){
        self.quizModel = quizModel
        
    }
    
    func makeConstraints(){
        
        //questionView.autoPinEdgesToSuperviewEdges()
        questionView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        
        
    }
    

}
