//
//  TitleTextField.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 21.03.2022.
//

import UIKit

class TitleTextField: UITextField {
    var textPadding = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
