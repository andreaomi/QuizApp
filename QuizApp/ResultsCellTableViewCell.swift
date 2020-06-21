//
//  ResultsCellTableViewCell.swift
//  QuizApp
//
//  Created by Andrea Omićević on 21/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    var placeLabel : UILabel!
    var usernameLabel : UILabel!
    var scoreLabel : UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        placeLabel = UILabel()
        placeLabel.text = "1"
        placeLabel.textAlignment = .center
        addSubview(placeLabel)
        
        usernameLabel = UILabel()
        usernameLabel.text = "name"
        usernameLabel.textAlignment = .center
        addSubview(usernameLabel)
        
        scoreLabel = UILabel()
        scoreLabel.text = "password"
        //scoreLabel.textAlignment = .center
        addSubview(scoreLabel)
    }
    
    func makeConstraints(){
        placeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        placeLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        placeLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15)
        placeLabel.autoSetDimensions(to: CGSize(width: "RANK".stringWidth + 10, height: 80))
        
        usernameLabel.autoAlignAxis(.horizontal, toSameAxisOf: placeLabel)
        usernameLabel.autoPinEdge(.leading, to: .trailing, of: placeLabel, withOffset: 50)
        
        scoreLabel.autoAlignAxis(.horizontal, toSameAxisOf: placeLabel)
        scoreLabel.autoPinEdge(.leading, to: .trailing, of: usernameLabel, withOffset: 50)
        scoreLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
    }
    
    func set(result : Results, index: Int){
        placeLabel.text = String(index+1)
        usernameLabel.text = result.username
        guard let score = result.score else {return}
        guard let doubleScore = Double(score) else {return}
        scoreLabel.text = String(format: "%.2f", doubleScore)
    }
    

}

extension String {
    var stringWidth: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        return boundingBox.width
    }
}

