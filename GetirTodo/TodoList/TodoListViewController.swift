//
//  ViewController.swift
//  GetirTodo
//
//  Created by Umut Afacan on 21.12.2020.
//

import UIKit

class TodoListViewController: UIViewController {
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        tableView.reloadData()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

