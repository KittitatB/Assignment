//
//  LTMANViewController.swift
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

protocol LTMANDisplayLogic: class
{
    func displayCelsius(viewModel: LTMAN.Celsius.ViewModel)
    func displayFahrenheit(viewModel: LTMAN.Fahrenheit.ViewModel)
}

class LTMANViewController: UIViewController, LTMANDisplayLogic
{
    var interactor: LTMANBusinessLogic?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = LTMANInteractor()
        let presenter = LTMANPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // MARK: Do something
    var isCelsius = true
    @IBOutlet weak var resultLabel: UILabel!
    
    func handleResultLabel(number: Int){
        if resultLabel.text == "0"{
            resultLabel.text = String(number)
        }else{
            resultLabel.text = "\(String(describing: resultLabel.text!))\(String(number))"
        }
    }
    
    func reset(){
        resultLabel.text = "0"
        isCelsius = true
    }
    
    func calculateCelsius(){
        let fahrenheit = Double(resultLabel.text!)
        let request = LTMAN.Celsius.Request(fahrenheit: fahrenheit!)
        
        interactor?.fahToCel(request: request)
    }
    
    func calculateFahrenheit(){
        let celsius = Double(resultLabel.text!)
        let request = LTMAN.Fahrenheit.Request(celsius: celsius!)
        
        interactor?.celToFah(request: request)
    }
    
    func displayCelsius(viewModel: LTMAN.Celsius.ViewModel) {
        resultLabel.text = String(viewModel.celsius)
    }
    
    func displayFahrenheit(viewModel: LTMAN.Fahrenheit.ViewModel) {
        resultLabel.text = String(viewModel.fahrenheit)
    }
    
    @IBAction func handleButtonPressed(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag {
        case 0...9:
            handleResultLabel(number: button.tag)
        case 10:
            if (resultLabel.text?.contains("."))!{
                return
            }else{
                resultLabel.text = "\(String(describing: resultLabel.text!))."
            }
        case 11:
            if isCelsius {
                return
            }else{
                calculateCelsius()
                isCelsius = true
            }
        case 12:
            if !isCelsius {
                return
            }else{
                calculateFahrenheit()
                isCelsius = false
            }
        case 13:
            reset()
        default:
            return
        }
    }
    
}


class ButtonWithBorder: UIButton{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 0.5
    }
}

