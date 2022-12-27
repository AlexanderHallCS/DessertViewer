//
//  Constants.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/26/22.
//

import Foundation

struct Constants {
    
    struct DessertVC {
        static let cellEdgeInsetPadding = 5.0
        static let cellHeightRatio = 1.65
        static let cellWidthRatio = 2.0
        static let cellSubConstant = 10.0
        static let navigationItemTitle = "Desserts"
    }
    
    struct DessertDetailVC {
        static let instructionsLabelText = "Instructions:"
        static let ingredientsLabelText = "Ingredients/Measurements:"
        
        static let minimumScaleFactor = 0.5
        static let listLabelFont = 20.0
        static let sectionLabelFont = 25.0
        
        struct Constraints {
            static let activityIndicatorTopPadding = 10.0
            
            static let imageViewDimRatio = 3.0
            
            static let listLabelHorizPadding = 20.0
            static let listLabelVertPadding = 10.0
            
            static let sectionLabelPadding = 10.0
        }
    }
    
    struct DessertCollectionViewCell {
        static let fontSize = 30.0
        static let minimumScaleFactor = 0.5
    }
    
    struct Endpoints {
        static let dessertList = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        static let dessert = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    }
    
    struct ErrorAlert {
        static let title = "Error!"
        static let dessertListMessage = "Could not get list of desserts! Please refresh."
        static let dessertMessage = "Could not get the dessert details! Please go back and try again."
    }
    
}
