//
//  TodoListTableViewCell.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 31.03.2022.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    static let identifier = "TodoListTableViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0))
        contentView.backgroundColor = .systemPink.withAlphaComponent(0.7)

        contentView.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 10, y: 5, width: contentView.width - 20, height: contentView.height - 10)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
