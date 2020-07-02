//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 01/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //var loginLabel : UILabel!
    
    var usernameTextField : UITextField!
    
    var passwordTextField : UITextField!
    
    var loginButton : UIButton!
    
    var textFields: [UITextField] {
        return [usernameTextField, passwordTextField]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        createConstrains()
        animateEverythingIn()
        view.backgroundColor = .white
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func buildViews(){
        
        //loginLabel = UILabel()
        //loginLabel.text="Login"
        //loginLabel.textAlignment = .center
        //funFactLabel.font = UIFont.systemFont(ofSize: 15)
        //view.addSubview(loginLabel)
        
        usernameTextField = UITextField()
        usernameTextField.placeholder = "username"
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(usernameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "password"
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1.5
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.backgroundColor = UIColor.magenta
        loginButton.autoSetDimensions(to: .init(width: 150, height: 40))
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(loginButton)

        
    }
    func createConstrains(){
        
        //loginLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 150)
        //loginLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        //loginLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        usernameTextField.autoPinEdge(toSuperviewEdge: .top, withInset: 200)
        usernameTextField.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        usernameTextField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        passwordTextField.autoPinEdge(.top, to: .bottom, of: usernameTextField , withOffset: 20)
        passwordTextField.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        passwordTextField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        
        //loginButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 300)
        loginButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 50)
        loginButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 50)
        loginButton.autoPinEdge(.top, to: .bottom, of: passwordTextField, withOffset: 20)
        
        
    }
    
    @objc func loginButtonTapped(_ sender: Any){
        print("LoginButton tapped")
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        if(username?.isEmpty)! || (password?.isEmpty)!
        {
            print("prazno")
            displayMessage(userMessage: "Sva polja moraju biti popunjena.")
            return
        }
        

        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        let myUrl = URL(string: "https://iosquiz.herokuapp.com/api/session")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("applications/json", forHTTPHeaderField: "Accept")
        
        let postString = ["username": username!,
                          "password": password!,
                        ] as [String: String]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Nešto je pošlo krivo. Pokušaj ponovo.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
    
            
            if error != nil
            {
                self.displayMessage(userMessage: "Ne može se izvesti ovaj zahtjev. Pokušaj ponovo.")
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json{
                    //print(parseJSON)
                    guard let accessToken = parseJSON ["token"] as? String else {
                        self.displayMessage(userMessage: "Navedeni username ne postoji. Pokušaj ponovo.")
                        return
                    }
                    
                    guard let userId = parseJSON["user_id"] as? Int else{
                        self.displayMessage(userMessage: "Navedeni username ne postoji. Pokušaj ponovo.")
                        return
                    }
                
                    if(accessToken.isEmpty)
                    {
                        self.displayMessage(userMessage: "Ne može se izvesti ovaj zahtjev. Pokušaj ponovo.")
                        return
                    }
                    DispatchQueue.main.async
                    {
                        UserDefaults.standard.set(accessToken, forKey: "accessToken")
                        
                        UserDefaults.standard.set(userId, forKey: "Id")
                        UserDefaults.standard.set(username, forKey: "username")
                        //UserDefaults.standard.set(accessToken, forKey: "True")
                        UserDefaults.standard.synchronize()
                        //let vc = QuizListController()
                        let vc = TabBarController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.hidesBottomBarWhenPushed = false
                    }
                    
                }else{
                    self.displayMessage(userMessage: "Ne može se izvesti ovaj zahtjev. Pokušaj ponovo.")
                }
            } catch {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                self.displayMessage(userMessage: "Ne može se izvesti ovaj zahtjev. Pokušaj ponovo.")
            }
        }
        task.resume()

    }


    func displayMessage(userMessage: String) -> Void{
        DispatchQueue.main.async {
            let error  = UIAlertController(title: "Pogreška", message: userMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            {(action:UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            error.addAction(ok)
            self.present(error, animated: true, completion: nil)
        }
    }
        
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
               textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
           } else {
               textField.resignFirstResponder()
           }
           return true
       }
    
    func animateEverythingIn(){
        navigationController?.isNavigationBarHidden  = true
        
        
        guard usernameTextField.text == "" else {return}
        guard passwordTextField.text == "" else {return}
        usernameTextField.becomeFirstResponder()
        

        
        UIView.animate(withDuration: 0, animations: {
            //self.quizNameLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            //self.quizNameLabel.alpha = 0
            self.usernameTextField.transform = CGAffineTransform(translationX: -self.view.bounds.size.width, y: 0)
            self.usernameTextField.alpha = 0
            self.passwordTextField.transform = CGAffineTransform(translationX: -self.view.bounds.size.width, y: 0)
            self.passwordTextField.alpha = 0
            self.loginButton.transform = CGAffineTransform(translationX: -self.view.bounds.size.width, y: 0)
            self.loginButton.alpha = 0
            
        }) { _ in
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseInOut, animations: {
            self.usernameTextField.transform = CGAffineTransform.identity
            self.usernameTextField.alpha = 1
        }) { _ in
        }
        UIView.animate(withDuration: 1.5, delay: 0.35, options: .curveEaseInOut, animations: {
            self.passwordTextField.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.passwordTextField.alpha = 1
        }) { _ in
        }
        UIView.animate(withDuration: 1.5, delay: 0.60, options: .curveEaseInOut, animations: {
            self.loginButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.loginButton.alpha = 1
        }) { _ in
        }
        
    }
       
    
    func animateEveryThingOut(){
       /* UIView.animate(withDuration: 0.3, animations: {
            self.quizNameLabel.transform = CGAffineTransform(translationX: 0, y: -200)
            self.quizNameLabel.alpha = 0.0
        }) { _ in
        }*/
        
        UIView.animate(withDuration: 0.3, delay: 0.15 , animations: {
            self.usernameTextField.transform = CGAffineTransform(translationX: 0, y: -200)
            self.usernameTextField.alpha = 0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.30, animations: {
            self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: -200)
            self.passwordTextField.alpha = 0.0
        }) { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.45, animations: {
            self.loginButton.transform = CGAffineTransform(translationX: 0, y: -200)
            self.loginButton.alpha = 0.0
        }) { _ in
        }
        
    }
}
