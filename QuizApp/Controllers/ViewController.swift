//
//  ViewController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 09/05/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit
import Kingfisher
import PureLayout

class ViewController: UIViewController {
    
    var getQizzesButton: UIButton!
    
    var funFactLabel : UILabel!
    
    var funFactNumberLabel : UILabel!
    
    var quizNameLabel: UILabel!
    
    var quizImageView : UIImageView!
    
    var questionView: QuestionView!
    
    private let networkServices = Network()
    
    private var quizzes : [QuizModel]?
    
    var errorLabel : UILabel!
    
    var logoutButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buildViews()
        createConstrains()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
          navigationController?.isNavigationBarHidden  = true
      }
      
    override func viewWillDisappear(_ animated: Bool) {
          navigationController?.isNavigationBarHidden = false
      }
    
    func buildViews(){
        getQizzesButton = UIButton()
        getQizzesButton.setTitle("DOHVATI", for: .normal)
        getQizzesButton.setTitleColor(.black, for: .normal)
        getQizzesButton.addTarget(self, action: #selector(getQuizzes), for: .touchUpInside)
        //getQizzesButton.backgroundColor = UIColor.blue
        //getQizzesButton.layer.cornerRadius = 5
        //getQizzesButton.layer.borderWidth = 1
        //getQizzesButton.layer.borderColor = UIColor.black.cgColor
        view.addSubview(getQizzesButton)
        
        funFactLabel = UILabel()
        funFactLabel.text="Fun Fact: "
        funFactLabel.font = UIFont.systemFont(ofSize: 15)
        funFactLabel.isHidden = true
        view.addSubview(funFactLabel)
        
        funFactNumberLabel = UILabel()
        funFactNumberLabel.text = "0"
        funFactNumberLabel.isHidden = true
        view.addSubview(funFactNumberLabel)
        
        quizNameLabel = UILabel()
        quizNameLabel.text = "Ime"
        //quizNameLabel.textAlignment = .center
        quizNameLabel.numberOfLines = 0
        quizNameLabel.isHidden = true
        view.addSubview(quizNameLabel)
        
        quizImageView = UIImageView()
        quizImageView.backgroundColor = .white
        quizImageView.isHidden = true
        view.addSubview(quizImageView)
        
        questionView = QuestionView()
        questionView.isHidden = true
        view.addSubview(questionView)
        
        errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
        
        logoutButton = UIButton()
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(logoutButton)
    }
    
    func createConstrains(){
        logoutButton.autoPinEdge(toSuperviewEdge: .top, withInset:20)
        logoutButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        //getQizzesButton.autoPinEdge(toSuperviewEdge: .top, withInset: 70)
        getQizzesButton.autoPinEdge(.top, to: .bottom, of: logoutButton, withOffset: 10)
        getQizzesButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        getQizzesButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        funFactLabel.autoPinEdge(.top, to: .bottom, of: getQizzesButton, withOffset: 25)
        funFactLabel.autoPinEdge(toSuperviewEdge: .leading, withInset:15)
        
        funFactNumberLabel.autoAlignAxis(.horizontal, toSameAxisOf: funFactLabel)
        funFactNumberLabel.autoPinEdge(.leading, to: .trailing, of: funFactLabel, withOffset: 5)
        
        quizNameLabel.autoPinEdge(.top, to: .bottom, of: funFactLabel, withOffset: 10)
        quizNameLabel.autoAlignAxis(.vertical, toSameAxisOf: view)
        
        quizImageView.autoPinEdge(.top, to: .bottom, of: quizNameLabel, withOffset: 10)
        quizImageView.autoAlignAxis(.vertical, toSameAxisOf: quizNameLabel)
        quizImageView.autoSetDimensions(to: CGSize(width:100, height: 100))
        
        questionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        questionView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        questionView.autoPinEdge(.top, to: .bottom, of: quizImageView, withOffset: 10)
        
        errorLabel.autoPinEdge(.top, to: .bottom, of: getQizzesButton, withOffset: 40)
        errorLabel.autoAlignAxis(.vertical, toSameAxisOf: getQizzesButton)
        
    }

    @objc func getQuizzes(){
        networkServices.getQuizzes(completionHandler: saveQuizzes(responseModel:))
        //.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func logoutButtonTapped(_ sender: Any){
        DispatchQueue.main.async {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "Id")
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    func checkCategory(category: Category) {
        switch category{
        case .SPORTS :
                quizNameLabel.backgroundColor = .blue
                quizImageView.backgroundColor = .blue
        case .SCIENCE:
                quizNameLabel.backgroundColor = .green
                quizImageView.backgroundColor = .green
        } 
    }

    func saveQuizzes(responseModel: ResponseModel?){
        guard let responseModel = responseModel else {
            DispatchQueue.main.sync{
                let error  = UIAlertController(title: "Pogreška", message: "Došlo je do greške.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                error.addAction(ok)
                present(error, animated: true, completion: nil)
                //errorLabel.text = "POGREŠKA!!"
                //errorLabel.isHidden = false
            }
        return
        }
        
        quizzes = responseModel.quizzes
        let num = responseModel.quizzes
            .map({$0.questions})
            .flatMap({$0.map({$0.question})})
            .filter({return $0.contains("NBA")})
            .count
        
        DispatchQueue.main.sync{
            
            funFactLabel.isHidden = false
            funFactNumberLabel.isHidden = false
            quizNameLabel.isHidden = false
            quizImageView.isHidden = false
            questionView.isHidden = false
            
            funFactNumberLabel.text = String(num)
            
            let quiz = responseModel.quizzes[2]
            quizNameLabel.text =  quiz.title
            
            guard let category = Category(rawValue: quiz.category) else {return}
            checkCategory(category: category)
                
            guard let imageURL = URL(string: quiz.image) else {return}
            quizImageView.kf.setImage(with: imageURL)
            questionView.setQuestion(questionModel: quiz.questions[0])
        }
    }
}



