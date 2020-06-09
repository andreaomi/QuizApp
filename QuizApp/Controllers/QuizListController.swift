//
//  QuizListController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 01/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class QuizListController: UIViewController {
    
    var tableView : UITableView!
    
    var getQuizzes : ResponseModel?
    
    var quizzes : [QuizModel]?
    
    var refreshControl: UIRefreshControl!
    
    var tableFooterView: QuizTableFooter!
    
    struct Cells{
        static let quizCell = "QuizTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        configureTableView()
    }
    
    func configureTableView(){
        buildViews()
        setTableViewDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden  = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func buildViews(){
        tableView = UITableView()
        tableView.register(QuizTableViewCell.self, forCellReuseIdentifier: Cells.quizCell)
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        tableFooterView = QuizTableFooter(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        tableFooterView.logoutDelegate = self
        tableView.tableFooterView = tableFooterView
    }
    
    func setUpData(){
        Network().getQuizzes(){ [weak self] (quizes) in
            guard let getQuizzes = quizes else {return}
            self?.getQuizzes = getQuizzes
            self?.refresh()
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //self.refreshControl.endRefreshing()
        }
    }

    func sectionNumber()->Int{
        guard let lista = getQuizzes?.quizzes.map({$0.category}) else {return 0}
        return NSSet(array: lista).count
    }
    
    func rowsInSection() -> [Int]{
        guard let sportSection = getQuizzes?.quizzes
                                .map({$0.category})
                                .filter({return $0.contains("SPORT")})
                                .count else {return [0]}
    
        guard let scienceSection = getQuizzes?.quizzes
                                .map({$0.category})
                                .filter({return $0.contains("SCIENCE")})
                                .count else {return [0]}
        
        return [sportSection, scienceSection]
    }
    
    func getQuiz() -> [[QuizModel]]{
        guard let sportQuiz = getQuizzes?.quizzes
            .filter({$0.category.contains("SPORTS")})
            else {
            return []
        }
        guard let scieneceQuiz = getQuizzes?.quizzes
            .filter({$0.category.contains("SCIENCE")})
            else{
                return []
        }
        let quizzes = [sportQuiz, scieneceQuiz]
        return quizzes
    }
    
}

extension QuizListController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNumber()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = QuizTableSectionHeader()
        let category = getQuiz()[section].map({$0.category})[0]
        guard let categoryCheck = Category(rawValue:category) else {return nil}
        view.checkCategory(category: categoryCheck)
        view.titleLabel.text = category
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInSection()[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.quizCell) as! QuizTableViewCell
        let quiz = getQuiz()[indexPath.section][indexPath.row]
        cell.set(quiz: quiz)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let quiz = getQuiz()[indexPath.section][indexPath.row]
        
        let quizScreenViewController = QuizScreenViewController()
        quizScreenViewController.quiz = quiz

        navigationController?.pushViewController(quizScreenViewController, animated: true)
        }
    
}

extension QuizListController: TableViewFooterViewDelegate {
    func logoutButton() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        defaults.removeObject(forKey: "Id")
        self.navigationController?.popViewController(animated:true)
    }
}



