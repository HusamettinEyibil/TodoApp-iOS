//
//  ViewController.swift
//  GetirTodo
//
//  Created by Umut Afacan on 21.12.2020.
//

import UIKit

protocol TodoListViewModelProtocol {
    var delegate: TodoListViewModelDelegate? { get set }
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func didTapPlusButton()
    func deleteItem(itemId: UUID)
}

enum TodoListViewRoute {
    case showDetail(item: TodoItem)
    case addNewItem(item: TodoItem)
}

class TodoListViewController: UIViewController {
    private var tableView = UITableView()

    private var items = [TodoListPresentation]()

    var viewModel: TodoListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        title = "Tasks"
        viewModel.viewDidLoad()
        configureTableView()
        configureAddButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidLoad()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.identifier)
        view.addSubview(tableView)
    }

    private func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapPlusButton))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func didTapPlusButton() {
        viewModel.didTapPlusButton()
    }
}

// MARK: - Table View Methods
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.identifier,
                                                       for: indexPath) as? TodoListTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row].title)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let actionSheet = UIAlertController(title: "Delete Item",
                                                message: "Are you sure delete this task?",
                                                preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [weak self]_ in
                guard let self = self else {return}
                let item = self.items[indexPath.row]
                self.viewModel.deleteItem(itemId: item.itemId)
                self.items.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }))

            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(actionSheet, animated: true)
        }
    }
}

// MARK: - View Model Delegate
extension TodoListViewController: TodoListViewModelDelegate {
    func didFetchItems(_ output: TodoListViewModelOutput) {
        switch output {
        case .showItemList(let items):
            self.items = items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func navigate(to route: TodoListViewRoute) {
        switch route {
        case .showDetail(let item):
            let viewController = TodoDetailBuilder.build(item: item)
            viewController.title = "Detail"
            viewController.button.isHidden = true
            viewController.titleTextField.isEnabled = false
            viewController.detailTextView.isEditable = false
            self.navigationController?.pushViewController(viewController, animated: true)
        case .addNewItem(let item):
            let viewController = TodoDetailBuilder.build(item: item)
            viewController.title = "Add New Item"
            viewController.button.setTitle("Add", for: .normal)
            viewController.button.isHidden = false
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
