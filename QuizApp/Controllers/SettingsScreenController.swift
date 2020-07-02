//
//  SettingsScreenController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 21/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class SettingsScreenController: UIViewController {
    
    var usernameLabel : UILabel!
    var realnameLabel : UILabel!
    var logoutButton : UIButton!

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
        usernameLabel = UILabel()
        usernameLabel.text = "USERNAME: "
        usernameLabel.textColor = .black
        view.addSubview(usernameLabel)
        
        realnameLabel = UILabel()
        guard let name = UserDefaults.standard.value(forKey: "username") else {return}
        realnameLabel.text = name as? String
        realnameLabel.textColor = .black
        view.addSubview(realnameLabel)
        
        
        logoutButton = UIButton()
        logoutButton.setTitle("LOGOUT", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.borderColor = UIColor.black.cgColor
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        logoutButton.autoSetDimensions(to: .init(width: 150, height: 40))
        logoutButton.backgroundColor = UIColor.blue
        view.addSubview(logoutButton)
        
    }
    
    func createConstrains(){
        usernameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 250)
        usernameLabel.autoPinEdge(toSuperviewMargin: .leading, withInset: 80)
        //usernameLabel.autoAlignAxis(.vertical, toSameAxisOf: view)
        
        realnameLabel.autoAlignAxis(.horizontal, toSameAxisOf: usernameLabel)
        realnameLabel.autoPinEdge(.leading, to: .trailing, of: usernameLabel, withOffset: 10)
        realnameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 80)
        
        logoutButton.autoPinEdge(.top, to: .bottom, of: usernameLabel, withOffset: 30)
        logoutButton.autoAlignAxis(.vertical, toSameAxisOf: view)
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "Id")
        self.navigationController?.popViewController(animated:true)
    }



}
