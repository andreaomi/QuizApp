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
    
    var correctAnswers : Int = 0
    
    var questionsStackView : UIStackView!
    
    var timer : Date!
    
    private let resultService = ResultService()

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
        quizTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(quizTitleLabel)
        
        imageQuiz = UIImageView()
        imageQuiz.kf.setImage(with: getImage())
        imageQuiz.backgroundColor = .red
        imageQuiz.layer.cornerRadius = 10
        imageQuiz.clipsToBounds = true
        view.addSubview(imageQuiz)
        
        startButton = UIButton()
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.autoSetDimensions(to: .init(width: 150, height: 40))
        startButton.layer.cornerRadius = 5
        startButton.layer.borderWidth = 1.5
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.backgroundColor = UIColor.white
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
        quizTitleLabel.autoAlignAxis(.vertical, toSameAxisOf: view)
        
        imageQuiz.autoPinEdge(.top, to: .bottom, of: quizTitleLabel, withOffset: 20)
        imageQuiz.autoSetDimensions(to: CGSize(width:200, height: 150))
        imageQuiz.autoAlignAxis(.vertical, toSameAxisOf: quizTitleLabel)
        
        startButton.autoPinEdge(.top, to: .bottom, of: imageQuiz, withOffset: 20)
        startButton.autoAlignAxis(.vertical, toSameAxisOf: imageQuiz)
        
        questionsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        
        quizScrollView.autoPinEdge(.top, to: .bottom, of: startButton, withOffset: 40)
        quizScrollView.autoAlignAxis(.vertical, toSameAxisOf: startButton)
        quizScrollView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        quizScrollView.autoMatch(.width, to: .width, of: view)

    }
    
    
    @objc func startButtonTapped(_ sender : UIButton){
        quizScrollView.isHidden = false
        timer = Date()
       }
    
    func scrollToAnotherQuestion() {
        let move = view.frame.size.width * CGFloat(questionsAnswered)
        quizScrollView.setContentOffset(CGPoint(x: move, y: 0), animated: true)
    }
    
    func sendResultsToService(quizId: Int, userId: Int, duration: Double, correctAnswers: Int ) {
        resultService.sendResults(quizId,userId,duration,correctAnswers) { check in
            self.backToQuizList(check: check)
        }
    }
       
     func backToQuizList(check: Int?) {
          DispatchQueue.main.async {
           if (check == 0) {
               print("200 OK")
               self.navigationController?.popViewController(animated: true)
           } else if (check == 1){
               print("401 UNATHORIZED")
               self.navigationController?.popViewController(animated: true)
           }
           else if (check == 2){
               print("403 FORBIDDEN")
               self.navigationController?.popViewController(animated: true)
           }
           else if (check == 3){
               print("404 NOT FOUND")
               self.navigationController?.popViewController(animated: true)
           }
           else if (check == 4){
               print("400 BAD REQUEST")
               self.navigationController?.popViewController(animated: true)
           }
           }
       }
}

extension QuizScreenViewController: QuestionViewDelegate {
    func clickedAnswer(answer: Int) {
        questionViews[questionsAnswered].isUserInteractionEnabled = false
        questionsAnswered += 1
        if(answer == 1) {
            correctAnswers += 1
        }
        guard let numberOfQuestions = self.quiz?.questions.count else {return}
        if(questionsAnswered < numberOfQuestions){
            Timer.scheduledTimer(withTimeInterval: 1.3, repeats: true) { timer in
                self.scrollToAnotherQuestion()
            }
        } else{
            let duration = Double(Date().timeIntervalSince(timer))
            print("Vrijeme rješavanja kviza: ",duration)
            print("Broj tocnih odgovora: ",correctAnswers,"/",numberOfQuestions)
            sendResultsToService(quizId: quiz!.id, userId: UserDefaults.standard.value(forKey: "Id")! as! Int, duration: duration, correctAnswers: correctAnswers)
        }
        
    }
    
    
}
    
    
