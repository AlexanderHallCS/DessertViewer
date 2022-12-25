//
//  DessertImageView.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/24/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class DessertImageView: UIImageView {

    var imageURLString: String?
    
    func loadImage(urlString: String) {
        
        imageURLString = urlString
        
        let url = URL(string: imageURLString!)
        
        image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        let request = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                self.image = image
                imageCache.setObject(image!, forKey: urlString as NSString)
            }
        }
        request.resume()
        
    }

}
