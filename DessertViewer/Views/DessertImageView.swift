//
//  DessertImageView.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/24/22.
//

import UIKit

class DessertImageView: UIImageView {

    var imageURLString: String?
    var imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(with urlString: String) {
        
        imageURLString = urlString
        
        let url = URL(string: imageURLString!)
        
        image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        let request = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                // TODO: Move error handling outside this function via an escaping closure to present an alert(or show display error image) when image does not load
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                self.image = image
                self.imageCache.setObject(image!, forKey: urlString as NSString)
            }
        }
        request.resume()
        
    }

}
