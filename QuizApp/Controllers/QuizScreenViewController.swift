//
//  QuizScreenViewController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 07/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class QuizScreenViewController: UIViewController{
    
    var quizTitleLabel : UILabel!
    
    var imageQuiz : UIImageView!
    
    var startButton : UIButton!
    
    var quizScrollView : UIScrollView!
    
    var quiz : QuizModel?
    
    var contentWidth : CGFloat = 0.0
    
    var questionViews: [QuestionView]! = []
    
    var questionsAnswered : Int = 0
    
    //var questionView : QuestionView!
    
    var pageControl : UIPageControl!
    
    var questionsStackView : UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        createConstrains()
    }
    
       
    func getImage() -> URL?{
        guard let imageURL = quiz?.image else {return nil}
        return URL(string: imageURL)
    }
       
    
    func buildViews(){
        quizTitleLabel = UILabel()
        quizTitleLabel.text = quiz?.title
        quizTitleLabel.textColor = .black
        view.addSubview(quizTitleLabel)
        
        imageQuiz = UIImageView()
        imageQuiz.kf.setImage(with: getImage())
        imageQuiz.backgroundColor = .red
        view.addSubview(imageQuiz)
        
        startButton = UIButton()
        startButton.setTitle("Start quiz", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 1.5
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.backgroundColor = UIColor.magenta
        startButton.addTarget(self, action: #selector(startButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(startButton)
        
        questionsStackView = UIStackView()
        questionsStackView.axis = .horizontal
        
        quizScrollView = UIScrollView()
        quizScrollView.isHidden = true
        quizScrollView.addSubview(questionsStackView)
        view.addSubview(quizScrollView)
        
        createQuestionViews()
    }
    
    
    func createQuestionViews(){
        guard let numberOfQuestions = self.quiz?.questions.count else {return}
        
        for i in 0..<numberOfQuestions{
            questionViews.append(QuestionView())
            questionViews[i].setQuestion(questionModel: (quiz?.questions[i])!)
            questionViews[i].delegate = self
            questionsStackView.addArrangedSubview(questionViews[i])
            questionViews[i].autoMatch(.width, to: .width, of: view)
        }
        
    }

    
    func createConstrains(){
        quizTitleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 80)
        //quizTitleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        //quizTitleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        quizTitleLabel.autoAlignAxis(.vertical, toSameAxisOf: view)
        
        imageQuiz.autoPinEdge(.top, to: .bottom, of: quizTitleLabel, withOffset: 20)
        imageQuiz.autoSetDimensions(to: CGSize(width:150, height: 120))
        imageQuiz.autoAlignAxis(.vertical, toSameAxisOf: quizTitleLabel)
        
        startButton.autoPinEdge(.top, to: .bottom, of: imageQuiz, withOffset: 20)
        startButton.autoAlignAxis(.vertical, toSameAxisOf: imageQuiz)
        
        questionsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        
        quizScrollView.autoPinEdge(.top, to: .bottom, of: startButton, withOffset: 2)
        quizScrollView.autoAlignAxis(.vertical, toSameAxisOf: startButton)
        quizScrollView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        quizScrollView.autoMatch(.width, to: .width, of: view)

    }
    
    
    @objc func startButtonTapped(_ sender : UIButton){
           quizScrollView.isHidden = false
           let questionView = QuestionView()
           questionView.delegate = self
           
       }
    
    func scrollToAnotherQuestion() {
        let deltax = view.frame.size.width * CGFloat(questionsAnswered)
        quizScrollView.setContentOffset(CGPoint(x: deltax, y: 0), animated: true)
    }


}

extension QuizScreenViewController: QuestionViewDelegate {
    func clickedAnswer() {
        questionViews[questionsAnswered].isUserInteractionEnabled = false
        questionsAnswered += 1
       
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.scrollToAnotherQuestion()
        }
        
    }
    
    
}
    
    
