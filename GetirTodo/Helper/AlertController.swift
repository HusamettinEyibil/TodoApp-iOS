//
//  AlertController.swift
//  GetirTodo
//
//  Created by Hüsamettin  Eyibil on 1.04.2022.
//

import UIKit

/// Show an alert message window with only one action button.
func showAlert(title: String,
               message: String,
               actionTitle: String,
               target: UIViewController,
               handler: ((UIAlertAction) -> Void)?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: actionTitle, style: .default, handler: handler)
    alert.addAction(action)
    target.present(alert, animated: true)
}
