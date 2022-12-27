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

extension String {
    
    func split(pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(0..<utf16.count))
        let ranges = [startIndex..<startIndex] + matches.map{Range($0.range, in: self)!} + [endIndex..<endIndex]
        return (0...matches.count).map {String(self[ranges[$0].upperBound..<ranges[$0+1].lowerBound])}
    }
}
