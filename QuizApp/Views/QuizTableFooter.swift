//
//  QuizTableFooter.swift
//  QuizApp
//
//  Created by Andrea Omićević on 04/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit
import PureLayout

protocol TableViewFooterViewDelegate: class {
    func logoutButton()
}

class QuizTableFooter: UIView {

    var logoutButton : UIButton!
    
    weak var logoutDelegate: TableViewFooterViewDelegate?
    
    @objc func logoutButtonTapped(_ sender: Any){
           logoutDelegate?.logoutButton()
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
        makeConstraints()
        backgroundColor = UIColor.yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViews(){
        logoutButton = UIButton()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.addTarget(self, action: #selector(QuizTableFooter.logoutButtonTapped(_:)), for: .touchUpInside)
        self.addSubview(logoutButton)
    }
    
    func makeConstraints(){
        logoutButton.autoPinEdge(.top, to: .top, of: self, withOffset: 20)
        logoutButton.autoAlignAxis(.vertical, toSameAxisOf: self)
    }
    
    
}

