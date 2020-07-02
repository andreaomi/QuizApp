//
//  SearchScreenController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 21/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class SearchScreenController: UIViewController {
    
    var searchTextField : UITextField!
    
    var searchButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        createConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden  = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func buildViews(){
        searchTextField = UITextField()
        searchTextField.placeholder = "search"
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(searchTextField)
        
        searchButton = UIButton()
        searchButton.setTitle("SEARCH", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.autoSetDimensions(to: .init(width: 150, height: 40))
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.black.cgColor
        view.addSubview(searchButton)
        
    }
    
    func createConstrains(){
        
        searchTextField.autoPinEdge(toSuperviewMargin: .top, withInset: 30)
        searchTextField.autoPinEdge(toSuperviewMargin: .trailing, withInset: 50)
        searchTextField.autoPinEdge(toSuperviewMargin: .leading, withInset: 50)
        //searchTextField.autoAlignAxis(.vertical, toSameAxisOf: view)
        
        searchButton.autoPinEdge(.top, to: .bottom, of: searchTextField, withOffset: 20)
        searchButton.autoAlignAxis(.vertical, toSameAxisOf: searchTextField)
        
    }
    

}
