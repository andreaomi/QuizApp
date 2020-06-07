//
//  QuizTableSectionHeader.swift
//  QuizApp
//
//  Created by Andrea Omićević on 04/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit
import PureLayout

class QuizTableSectionHeader : UIView {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.darkGray
        self.addSubview(titleLabel)
        titleLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 16.0)
        titleLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkCategory(category: Category) {
        switch category{
        case .SPORTS :
                titleLabel.backgroundColor = .blue
                backgroundColor = UIColor.blue
        case .SCIENCE:
                titleLabel.backgroundColor = .green
                backgroundColor = UIColor.green
        }
    }
    
}
