//
//  TodoDetailViewController.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 20.03.2022.
//

import UIKit
protocol TodoDetailViewModelProtocol {
    var delegate: TodoDetailViewModelDelegate? { get set }
    func viewDidLoad()
    func didTapAddButton(item: TodoItem)
    func didTapSaveButton(item: TodoItem)
}

class TodoDetailViewController: UIViewController {
    
    let titleTextField: TitleTextField = {
        let textField = TitleTextField()
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.backgroundColor = .systemBackground
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let detailTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.contentInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 15)
        textView.backgroundColor = .systemBackground
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        return textView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    var editButton: UIBarButtonItem?
    
    var itemId: UUID?
    
    var viewModel: TodoDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
        view.backgroundColor = .systemGray5
        viewModel.viewDidLoad()
        configureEditButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layoutFrame = view.safeAreaLayoutGuide.layoutFrame
        view.addSubview(titleTextField)
        titleTextField.frame = CGRect(x: 15, y: view.safeAreaInsets.top + 10, width: layoutFrame.width - 30, height: 50)
        view.addSubview(detailTextView)
        detailTextView.frame = CGRect(x: 15, y: titleTextField.bottom + 10, width: layoutFrame.width - 30, height: 250)
        view.addSubview(button)
        button.frame = CGRect(x: 15, y: detailTextView.bottom + 20, width: layoutFrame.width / 1.5, height: 50)
        button.center.x = view.center.x
    }
    
    @objc private func didTapButton() {
        guard let buttonText = button.titleLabel?.text else {return}
        let title = titleTextField.text ?? ""
        let detail = detailTextView.text ?? ""
        
        switch buttonText {
        case "Add":
            let newItem = TodoItem(itemId: UUID(), title: title, detail: detail)
            viewModel.didTapAddButton(item: newItem)
        case "Save":
            titleTextField.isEnabled = false
            detailTextView.isEditable = false
            button.isHidden = true
            editButton?.isEnabled = true
            
            let item = TodoItem(itemId: itemId, title: title, detail: detail)
            viewModel.didTapSaveButton(item: item)
        default:
            break
        }
    }
    
    private func configureEditButton() {
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditButton))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc private func didTapEditButton() {
        titleTextField.isEnabled = true
        detailTextView.isEditable = true
        button.isHidden = false
        editButton?.isEnabled = false
    }

}

extension TodoDetailViewController: TodoDetailViewModelDelegate {
    func showDetail(item: TodoItem) {
        itemId = item.itemId
        titleTextField.text = item.title
        detailTextView.text = item.detail
    }
    
    func didCreateNewItem() {
        let alert = UIAlertController(title: "Success", message: "New item is successfully created.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
