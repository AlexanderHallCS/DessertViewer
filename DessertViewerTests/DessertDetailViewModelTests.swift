//
//  DessertDetailViewModelTests.swift
//  DessertViewerTests
//
//  Created by Alexander Hall on 12/26/22.
//

@testable import DessertViewer
import XCTest

final class DessertDetailViewModelTests: XCTestCase {

    var dessertDetailViewModel: DessertDetailViewModel!
    
    override func setUp() {
        super.setUp()
        dessertDetailViewModel = DessertDetailViewModel(dessert: Dessert(idMeal: "", strMeal: "", strMealThumb: ""))
    }
    
    override func tearDown() {
        super.tearDown()
        dessertDetailViewModel = nil
    }
    
    func test_valid_format_instructions() {
        XCTAssertEqual(dessertDetailViewModel.formatInstructions(""), "")
        
        // single instruction
        XCTAssertEqual(dessertDetailViewModel.formatInstructions("perform action"), "1. perform action")
        XCTAssertEqual(dessertDetailViewModel.formatInstructions("perform action\r\n"), "1. perform action")
        XCTAssertEqual(dessertDetailViewModel.formatInstructions("perform action\r\n\r\n"), "1. perform action")
        XCTAssertEqual(dessertDetailViewModel.formatInstructions("perform action. "), "1. perform action.")
        
        
        // multiple instructions
        XCTAssertEqual(dessertDetailViewModel.formatInstructions("perform action\r\nperform second action"), "1. perform action\n2. perform second action")
        XCTAssertEqual(dessertDetailViewModel.formatInstructions("perform action\r\n\r\nperform second action"), "1. perform action\n2. perform second action")
        XCTAssertEqual(dessertDetailViewModel.formatInstructions("perform action. perform second action"), "1. perform action.\n2. perform second action")
    }
    
    func test_valid_format_ingredients_and_measures() {
        XCTAssertEqual(dessertDetailViewModel.formatIngredientsAndMeasures([""], [""]), "")
        XCTAssertEqual(dessertDetailViewModel.formatIngredientsAndMeasures(["first ingredient"], ["1"]), "• 1 first ingredient")
        XCTAssertEqual(dessertDetailViewModel.formatIngredientsAndMeasures(["first ingredient", "second ingredient"], ["1", "2"]), "• 1 first ingredient\n• 2 second ingredient")
        XCTAssertEqual(dessertDetailViewModel.formatIngredientsAndMeasures(["first ingredient", "second ingredient"], ["1", "2"]), "• 1 first ingredient\n• 2 second ingredient")
        
        // either ingredients or measures being empty yields empty instructions
        XCTAssertEqual(dessertDetailViewModel.formatIngredientsAndMeasures([], []), "")
        XCTAssertEqual(dessertDetailViewModel.formatIngredientsAndMeasures(["ingredient 1"], []), "")
        XCTAssertEqual(dessertDetailViewModel.formatIngredientsAndMeasures([], ["measure 1"]), "")
    }
}
