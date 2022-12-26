//
//  Extensions.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/26/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action -> Void in
            alert.dismiss(animated: true)
        })
        self.present(alert, animated: true)
    }
}
