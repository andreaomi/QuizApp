//
//  QuizScreenViewController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 07/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class QuizScreenViewController: UIViewController {
    
    var quizTitleLabel : UILabel!
    
    var imageQuiz : UIImageView!
    
    var startButton : UIButton!
    
    var quizScrollView : QuizScrollView!
    
    var quiz : QuizModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        createConstrains()
        //getQuiz()
    }
    
    convenience init(quizModel : QuizModel){
        self.init()
        self.quiz = quizModel
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
        view.addSubview(startButton)
        

        quizScrollView = QuizScrollView()
        quizScrollView.setUpQuestionView(quizModel: quiz)
        view.addSubview(quizScrollView)

    
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
        
        quizScrollView.autoPinEdge(.top, to: .bottom, of: startButton, withOffset: 20)
        quizScrollView.autoAlignAxis(.vertical, toSameAxisOf: startButton)
        quizScrollView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        quizScrollView.autoMatch(.width, to: .width, of: view)

    }
    
    

}
    
    