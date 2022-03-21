//
//  TodoDetailViewController.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    let titleTextField: TitleTextField = {
        let textField = TitleTextField()
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = .systemBackground
        return textField
    }()
    
    let detailTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.contentInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 15)
        textView.backgroundColor = .systemBackground
        return textView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
        view.backgroundColor = .systemGray5
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layoutFrame = view.safeAreaLayoutGuide.layoutFrame
        view.addSubview(titleTextField)
        titleTextField.frame = CGRect(x: 15, y: view.safeAreaInsets.top + 10, width: layoutFrame.width - 30, height: 50)
        view.addSubview(detailTextView)
        detailTextView.frame = CGRect(x: 15, y: titleTextField.bottom + 10, width: layoutFrame.width - 30, height: 250)
        view.addSubview(saveButton)
        saveButton.frame = CGRect(x: 15, y: detailTextView.bottom + 10, width: layoutFrame.width - 30, height: 50)
    }

}
