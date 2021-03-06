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
    
    var resultsButton : UIButton!
    
    private let resultService = ResultService()
    
    private let topResultsService = TopResultsServices()
    
    var getResults : [Results]?
    
    var someDict:[String:String?] = [:]
    
    var counter : Int = 0
    
    var index : Int = 0
    
    var topResults : [Results]? = []
    
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
        
        resultsButton = UIButton()
        resultsButton.setTitle("RESULTS", for: .normal)
        resultsButton.setTitleColor(.black, for: .normal)
        resultsButton.autoSetDimensions(to: .init(width: 150, height: 40))
        resultsButton.layer.cornerRadius = 5
        resultsButton.layer.borderWidth = 1.5
        resultsButton.layer.borderColor = UIColor.black.cgColor
        resultsButton.backgroundColor = UIColor.white
        resultsButton.addTarget(self, action: #selector(resultsButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(resultsButton)
        
        
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
        
        resultsButton.autoPinEdge(.top, to: .bottom, of: startButton, withOffset: 20)
        resultsButton.autoAlignAxis(.vertical, toSameAxisOf: imageQuiz)
        
        questionsStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        questionsStackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        
        quizScrollView.autoPinEdge(.top, to: .bottom, of: resultsButton, withOffset: 40)
        quizScrollView.autoAlignAxis(.vertical, toSameAxisOf: resultsButton)
        quizScrollView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        quizScrollView.autoMatch(.width, to: .width, of: view)
        
    }
    
    @objc func startButtonTapped(_ sender : UIButton){
        quizScrollView.isHidden = false
        timer = Date()
    }
    
    @objc func resultsButtonTapped(_ sender : UIButton){
        print("Tapped")
        topResultsService.getTopResults(quiz!.id){ [weak self] (results) in
            guard let getResults = results else {return}
            //            self?.getResults = getResults
            
            while self!.counter < 20{
                if(getResults[self!.index].score != nil){
                    self?.counter += 1
                    //print(getResults[self!.index])
                    self!.topResults?.append(getResults[self!.index])
                }
                self?.index+=1
            }
            
            guard let results = self!.topResults else { return }
            DispatchQueue.main.async {
                let vc = LeaderboardController()
                vc.topResults = results
                self!.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
    func scrollToAnotherQuestion() {
        let move = view.frame.size.width * CGFloat(questionsAnswered)
        quizScrollView.setContentOffset(CGPoint(x: move, y: 0), animated: true)
    }
    
    func sendResultsToService(quizId: Int, userId: Int, duration: Double, correctAnswers: Int ) {
        resultService.sendResults(quizId,userId,duration,correctAnswers) { responseCode in
            self.backToQuizList(responseCode: responseCode)
        }
    }
    
    
    func backToQuizList(responseCode: ResponseCodes?) {
        if responseCode == ResponseCodes.ok {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            } else {
                DispatchQueue.main.async {
                   self.showAlert(responseCode: responseCode)
                }
            }
    }
    
    func showAlert(responseCode: ResponseCodes?) {
        let defaultErrorMessage = "There wasn't any response!"
        
        let alert = UIAlertController(title: "Send again?", message: "Error was: \(responseCode?.message ?? defaultErrorMessage)", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController( animated: true)
        }))
       
        self.present(alert, animated: true, completion: nil)
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


