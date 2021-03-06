//
//  LTMANPresenter.swift
//  LTMANAssignment
//
//  Created by MuMhu on 10/2/2562 BE.
//  Copyright (c) 2562 MuMhu. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LTMANPresentationLogic
{
    func presentCelsius(response: LTMAN.Celsius.Response)
    func presentFahrenheit(response: LTMAN.Fahrenheit.Response)
}

class LTMANPresenter: LTMANPresentationLogic
{
    weak var viewController: LTMANDisplayLogic?
    
    // MARK: Do something
    
    func presentCelsius(response: LTMAN.Celsius.Response) {
        let viewModel = LTMAN.Celsius.ViewModel(celsius: response.celsius)
        viewController?.displayCelsius(viewModel: viewModel)
    }
    
    func presentFahrenheit(response: LTMAN.Fahrenheit.Response) {
        let viewModel = LTMAN.Fahrenheit.ViewModel(fahrenheit: response.fahrenheit)
         viewController?.displayFahrenheit(viewModel: viewModel)
    }
}
