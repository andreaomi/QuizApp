//
//  ResultTableHeader.swift
//  QuizApp
//
//  Created by Andrea Omićević on 21/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class ResultTableHeader: UIView {
    
    var placeLabel : UILabel!
    var usernameLabel : UILabel!
    var scoreLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        buildViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        placeLabel = UILabel()
        placeLabel.text = "RANK"
        placeLabel.textAlignment = .center
        self.addSubview(placeLabel)
        
        usernameLabel = UILabel()
        usernameLabel.text = "USERNAME"
        self.addSubview(usernameLabel)
        
        scoreLabel = UILabel()
        scoreLabel.text = "SCORE"
        self.addSubview(scoreLabel)
    }
    
    func makeConstraints(){
        placeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        placeLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        placeLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15)
        placeLabel.autoSetDimensions(to: CGSize(width: "RANK".stringWidth + 10, height: 80))
        
        usernameLabel.autoAlignAxis(.horizontal, toSameAxisOf: placeLabel)
        usernameLabel.autoPinEdge(.leading, to: .trailing, of: placeLabel, withOffset: 75)
        
        scoreLabel.autoAlignAxis(.horizontal, toSameAxisOf: placeLabel)
        scoreLabel.autoPinEdge(.leading, to: .trailing, of: usernameLabel, withOffset: 50)
        scoreLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
    }
    
    
}
