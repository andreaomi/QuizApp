//
//  LeaderboardController.swift
//  QuizApp
//
//  Created by Andrea Omićević on 21/06/2020.
//  Copyright © 2020 Andrea Omićević. All rights reserved.
//

import UIKit

class LeaderboardController: UIViewController {
    
    var closeButton : UIButton!
    var tableView : UITableView!
    //var getResults : [Results]?
    var topResults : [Results] = []
    
    struct Cells{
        static let resultCell = "ResultsTableViewCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        createConstrains()
        setTableViewDelegate()

    }
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func buildViews(){
        closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped(_ :)), for: .touchUpInside)
        view.addSubview(closeButton)
        
        tableView = UITableView()
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: Cells.resultCell)
        tableView.rowHeight = 50
        view.addSubview(tableView)
        
    }
    
    func createConstrains(){
        
        closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        closeButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 10)
        
        tableView.autoPinEdge(.top, to: .bottom, of: closeButton, withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        
    }
    
    @objc func closeButtonTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LeaderboardController: UITableViewDelegate,  UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.resultCell) as! ResultsTableViewCell
        let index = indexPath.row
        let result = topResults[index]
        cell.set(result : result, index : index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50.0
       }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ResultTableHeader()
        return view
    }
    
    
}
