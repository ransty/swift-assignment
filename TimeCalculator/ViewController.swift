//
//  ViewController.swift
//  TimeCalculator
//
//  Created by Porcaro, Keano Dean - porkd002 on 7/9/17.
//  Copyright © 2017 Porcaro, Keano Dean - porkd002. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var wheelDiameterLabel: UILabel!
    @IBOutlet weak var wheelDiameterTextField: UITextField!
    @IBOutlet weak var rpmLabel: UILabel!
    @IBOutlet weak var rpmTextField: UITextField!
    @IBOutlet weak var targetDistanceLabel: UILabel!
    @IBOutlet weak var targetDistanceTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        wheelDiameterTextField.keyboardType = UIKeyboardType.numberPad;
        rpmTextField.keyboardType = UIKeyboardType.numberPad;
        targetDistanceTextField.keyboardType = UIKeyboardType.numberPad;
        
        self.rpmTextField.delegate = self;
        self.wheelDiameterTextField.delegate = self;
        self.targetDistanceTextField.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: Actions
    
    @IBAction func calculateFormula(_ sender: Any) {
        // Distance / ((pi * Diameter) / 60) * RPM) = Time (ms)
        // First we need all the variables
        let distance: String = targetDistanceTextField.text!
        let diameter: String = wheelDiameterTextField.text!
        let rpm: String = rpmTextField.text!
        
        // now we need to convert them to double since pi is a double
        let intDistance: Double = Double(distance)!
        let intDiameter: Double = Double(diameter)!
        let intRPM: Double = Double(rpm)!
        
        // calculate the result
        let result: Double = (intDistance / ((Double.pi * intDiameter) / 60) * intRPM);
        
        // we don't care about more than 2 decimal places, so lets round
        let roundedResult: Double = Double(round(100*result)/100);
        
        // convert rounded result to string so we can print it
        let stringRoundedResult: String = String(roundedResult);
        
        // hide the keyboard
        self.rpmTextField.resignFirstResponder();
        self.wheelDiameterTextField.resignFirstResponder();
        self.targetDistanceTextField.resignFirstResponder();
        
        // now set result label to the result!
        resultLabel.text = stringRoundedResult + " milliseconds";
        
    }
    
    // hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // hide keyboard when user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.rpmTextField.resignFirstResponder();
        self.wheelDiameterTextField.resignFirstResponder();
        self.targetDistanceTextField.resignFirstResponder();
        return true;
    }
    
    // stop user using other numbers than 0123456789 otherwise the application will crash
    // taken from: https://stackoverflow.com/questions/30973044/how-to-restrict-uitextfield-to-take-only-numbers-in-swift
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered

    }

}

