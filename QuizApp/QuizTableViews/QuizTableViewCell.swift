//
//  QuizTableViewCell.swift
//  QuizApp
//
//  Created by Andrea Omićević on 04/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    var quizImageView: UIImageView!
    
    var quizTitleLabel : UILabel!
    
    var quizDescriptionLabel : UILabel!
    
    var levelImage1 = UIImageView()
    
    var levelImage2 = UIImageView()
    
    var levelImage3 = UIImageView()
    
    var imageStackView : UIStackView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        quizImageView = UIImageView()
        quizImageView.backgroundColor = .red
        quizImageView.layer.cornerRadius = 5
        quizImageView.clipsToBounds = true
        addSubview(quizImageView)
        
        quizTitleLabel = UILabel()
        quizTitleLabel.numberOfLines = 1
        quizTitleLabel.textAlignment = .left
        quizTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(quizTitleLabel)
        
        quizDescriptionLabel = UILabel()
        quizDescriptionLabel.numberOfLines = 0
        quizDescriptionLabel.textAlignment = .left
        quizDescriptionLabel.font = quizDescriptionLabel.font.withSize(13)
        addSubview(quizDescriptionLabel)
        
        imageStackView = UIStackView()
        imageStackView.axis = .horizontal
        imageStackView.spacing = 1
        imageStackView.distribution = .fillEqually
        addSubview(imageStackView)
        
        levelImage1.image = #imageLiteral(resourceName: "img1")
        levelImage2.image = #imageLiteral(resourceName: "img1")
        levelImage3.image = #imageLiteral(resourceName: "img1")
        imageStackView.addArrangedSubview(levelImage1)
        imageStackView.addArrangedSubview(levelImage2)
        imageStackView.addArrangedSubview(levelImage3)

    }
    
    func makeConstraints(){
        
        quizImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        quizImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        quizImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        quizImageView.autoSetDimensions(to: CGSize(width: 100, height: 80))
        
        quizTitleLabel.autoPinEdge(.leading, to: .trailing, of: quizImageView, withOffset: 5)
        quizTitleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        levelImage1.autoSetDimensions(to: CGSize(width: 12, height: 12))
        levelImage2.autoSetDimensions(to: CGSize(width: 12, height: 12))
        levelImage3.autoSetDimensions(to: CGSize(width: 12, height: 12))
        
        imageStackView.autoPinEdge(.leading, to: .trailing, of: quizTitleLabel, withOffset: 2)
        imageStackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
        imageStackView.autoAlignAxis(.horizontal, toSameAxisOf: quizTitleLabel)
        
        quizDescriptionLabel.autoPinEdge(.top, to: .bottom, of: quizTitleLabel, withOffset: 15)
        quizDescriptionLabel.autoPinEdge(.leading, to: .trailing, of: quizImageView, withOffset: 5)
        quizDescriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 5)
        quizDescriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        
    }
    
    func set(quiz: QuizModel){
        quizTitleLabel.text = quiz.title
        quizDescriptionLabel.text = quiz.description
        
        guard let imageURL = URL(string: quiz.image) else {return}
        quizImageView.kf.setImage(with: imageURL)
       
        switch quiz.level {
        case 1:
            levelImage1.isHidden = true
            levelImage2.isHidden = true
        case 2:
            levelImage1.isHidden = true
        default:
            print("tezina kviza je 3.")
        }
        
    }
    
}
