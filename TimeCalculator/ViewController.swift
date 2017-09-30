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
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var checkButtonDistance: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var checkButtonDiameter: UIButton!
    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var textBoxInfo: UITextView!
    @IBOutlet weak var meterCheck: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var imperialButton: UIButton!
    
    // instance variables
    var distanceCalc: Bool = false;
    var rpmCalc: Bool = false;
    var diameterCalc: Bool = false;
    var meters: Bool = false;
    var mmWheelDiameter: Bool = false;
    var metric: Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textBoxInfo.isUserInteractionEnabled = false;

        // Do any additional setup after loading the view, typically from a nib.
        wheelDiameterTextField.keyboardType = UIKeyboardType.numberPad;
        rpmTextField.keyboardType = UIKeyboardType.numberPad;
        targetDistanceTextField.keyboardType = UIKeyboardType.numberPad;
        timeTextField.keyboardType = UIKeyboardType.numberPad;
        
        self.rpmTextField.delegate = self;
        self.wheelDiameterTextField.delegate = self;
        self.targetDistanceTextField.delegate = self;
        self.timeTextField.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: Actions
    
    @IBAction func calculateFormula(_ sender: Any) {
        // before we calculate anything, check to see if all the textfields are empty/null
        if (rpmCalc == true) {
            if (!(targetDistanceTextField.text?.isEmpty)! && !(timeTextField.text?.isEmpty)! && !(wheelDiameterTextField.text?.isEmpty)!) {
                
                let distance: String = targetDistanceTextField.text!
                let diameter: String = wheelDiameterTextField.text!
                let time: String = timeTextField.text!
                
                var intDistance: Double = Double(distance)!
                var intDiameter: Double = Double(diameter)!
                let intTime: Double = Double(time)!
                
                
                // calculate the result
                
                // k = diameter
                // d = distance
                // p = Double.pi
                // r = RPM
                
                // if metric, convert millimeters to 0.0393701
                
                if (!metric && !meters) {
                    intDistance = intDistance / 25.4;
                    intDiameter = intDiameter / 25.4;
                } else if (!metric && meters) {
                    intDistance = intDistance / 0.3048;
                    intDiameter = intDiameter / 0.3048;
                }
                
                // r = (k * p * t) / (60 * d)
                
                let result: Double = (intDiameter * Double.pi * intTime) / (60 * intDistance);
                
                // we don't care about more than 2 decimal places, so lets round
                let roundedResult: Double = Double(round(100*result)/100);
                
                // convert rounded result to string so we can print it
                let stringRoundedResult: String = String(roundedResult);
                
                // hide the keyboard
                self.timeTextField.resignFirstResponder();
                self.wheelDiameterTextField.resignFirstResponder();
                self.targetDistanceTextField.resignFirstResponder();
                
                resultLabel.text = stringRoundedResult + " RPM";
            }
        } else if (distanceCalc == true) {
            if (!(rpmTextField.text?.isEmpty)! && !(timeTextField.text?.isEmpty)! && !(wheelDiameterTextField.text?.isEmpty)!) {
                
                let rpm: String = rpmTextField.text!
                let diameter: String = wheelDiameterTextField.text!
                let time: String = timeTextField.text!
                
                // now we need to convert them to double since pi is a double
                let intRPM: Double = Double(rpm)!
                var intDiameter: Double = Double(diameter)!
                let intTime: Double = Double(time)!
                
                // calculate the result
                
                // k = diameter
                // d = distance
                // p = Double.pi
                // r = RPM
                
                // d = (k * p * t) / (60 * r)
                //
                
                if (!metric && !meters) {
                    intDiameter = intDiameter / 25.4;
                } else if (!metric && meters) {
                    intDiameter = intDiameter / 0.3048;
                }
                
                var result: Double = (intDiameter * Double.pi * intTime) / (60 * intRPM);
                
                if (meters) {
                    result = result / 1000;
                }
                // we don't care about more than 2 decimal places, so lets round
                let roundedResult: Double = Double(round(100*result)/100);
                
                // convert rounded result to string so we can print it
                let stringRoundedResult: String = String(roundedResult);
                
                // hide the keyboard
                self.timeTextField.resignFirstResponder();
                self.wheelDiameterTextField.resignFirstResponder();
                self.rpmTextField.resignFirstResponder();
                
                if (meters && metric) {
                    resultLabel.text = stringRoundedResult + " m";
                } else if (!metric && !meters) {
                    resultLabel.text = stringRoundedResult + " in";
                } else if (!metric && meters) {
                    resultLabel.text = stringRoundedResult + " ft";
                }
                else {
                resultLabel.text = stringRoundedResult + " mm";
                }
                
            }
            // distance calc NOT TIME CALC
        } else if (diameterCalc == true) {
            if (!(targetDistanceTextField.text?.isEmpty)! && !(rpmTextField.text?.isEmpty)! && !(timeTextField.text?.isEmpty)!) {
                
                let distance: String = targetDistanceTextField.text!
                let time: String = timeTextField.text!
                let rpm: String = rpmTextField.text!
                
                // now we need to convert them to double since pi is a double
                var intDistance: Double = Double(distance)!
                let intTime: Double = Double(time)!
                let intRPM: Double = Double(rpm)!
                
                // k = diameter
                // d = distance
                // p = Double.pi
                // r = RPM
                if (!metric && !meters) {
                    intDistance = intDistance / 25.4;
                } else if (!metric && meters) {
                    intDistance = intDistance / 0.3048;
                }
                // k = (60 * d * r) / (p * t)
                
                // calculate the result
                var result: Double = (60 * intDistance * intRPM) / (Double.pi * intTime);
                
                if (meters) {
                    result = result / 1000;
                }
                // we don't care about more than 2 decimal places, so lets round
                let roundedResult: Double = Double(round(100*result)/100);
                
                // convert rounded result to string so we can print it
                let stringRoundedResult: String = String(roundedResult);
                
                // hide the keyboard
                self.rpmTextField.resignFirstResponder();
                self.timeTextField.resignFirstResponder();
                self.targetDistanceTextField.resignFirstResponder();
                
                if (meters && metric) {
                    resultLabel.text = stringRoundedResult + " m";
                } else if (!metric && !meters) {
                    resultLabel.text = stringRoundedResult + " in"
                } else if (!metric && meters) {
                    resultLabel.text = stringRoundedResult + " ft";
                }
                else {
                resultLabel.text = stringRoundedResult + " mm";
                }
            }
        } else { // default time calc
            if (!(targetDistanceTextField.text?.isEmpty)! && !(rpmTextField.text?.isEmpty)! && !(wheelDiameterTextField.text?.isEmpty)!) {
                // Distance / ((pi * Diameter) / 60) * RPM) = Time (ms)
                // First we need all the variables
                let distance: String = targetDistanceTextField.text!
                let diameter: String = wheelDiameterTextField.text!
                let rpm: String = rpmTextField.text!
                
                // now we need to convert them to double since pi is a double
                var intDistance: Double = Double(distance)!
                var intDiameter: Double = Double(diameter)!
                let intRPM: Double = Double(rpm)!
                
                if (metric == false) {
                    intDistance = intDistance / 25.4;
                    intDiameter = intDiameter / 25.4;
                }
                
                
                // calculate the result
                var result: Double = (intDistance / ((Double.pi * intDiameter) / 60) * intRPM);
                
                if (meters) {
                    result = result / 1000;
                }
                
                // we don't care about more than 2 decimal places, so lets round
                let roundedResult: Double = Double(round(100*result)/100);
                
                // convert rounded result to string so we can print it
                let stringRoundedResult: String = String(roundedResult);
                
                if (meters) {
                    resultLabel.text = stringRoundedResult + " s";
                } else {
                resultLabel.text = stringRoundedResult + " ms";
                }
                
                // hide the keyboard
                self.rpmTextField.resignFirstResponder();
                self.wheelDiameterTextField.resignFirstResponder();
                self.targetDistanceTextField.resignFirstResponder();
                

            }

        }
        
    }
    
    // rpm calculator
    @IBAction func checkBoxButton(_ checkButton: UIButton) {
        if (rpmCalc == true) {
            checkButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            rpmCalc = false;
            rpmTextField.isUserInteractionEnabled = true;
        } else if (rpmCalc == false) {
            checkButton.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            if (distanceCalc == true || diameterCalc) {
                distanceCalc = false;
                diameterCalc = false;
                checkButtonDistance.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal);
                checkButtonDiameter.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
                targetDistanceTextField.isUserInteractionEnabled = true;
                wheelDiameterTextField.isUserInteractionEnabled = true;
            }
            rpmCalc = true;
            rpmTextField.isUserInteractionEnabled = false;
            rpmTextField.text = "";
            print("CLICKED RPM BUTTON");
        }
    }
    
    // distance calculator
    @IBAction func checkBoxButtonDistance(_ checkButton: UIButton) {
        if (distanceCalc == true) {
            checkButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            distanceCalc = false;
            targetDistanceTextField.isUserInteractionEnabled = true;
        } else if (distanceCalc == false) {
            if (rpmCalc == true || diameterCalc == true) {
                rpmCalc = false;
                diameterCalc = false;
                self.checkButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal);
                self.checkButtonDiameter.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
                rpmTextField.isUserInteractionEnabled = true;
                wheelDiameterTextField.isUserInteractionEnabled = true;
            }
            checkButton.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            distanceCalc = true;
            targetDistanceTextField.text = "";
            targetDistanceTextField.isUserInteractionEnabled = false;
            print("CLICKED DISTANCE BUTTON");
        }
    }
    
    
    @IBAction func checkButtonDiameter(_ button: UIButton) {
        if (diameterCalc == true) {
            button.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            diameterCalc = false;
            wheelDiameterTextField.isUserInteractionEnabled = true;
        } else if (diameterCalc == false) {
            if (rpmCalc == true || distanceCalc == true) {
                rpmCalc = false;
                distanceCalc = false;
                self.checkButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
                self.checkButtonDistance.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
                rpmTextField.isUserInteractionEnabled = true;
                targetDistanceTextField.isUserInteractionEnabled = true;
            }
            button.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            diameterCalc = true;
            wheelDiameterTextField.isUserInteractionEnabled = false;
            wheelDiameterTextField.text = "";
            print("CLICKED DIAMETER BUTTON");
        }
    }
    
    @IBAction func meterCheck(_ button: UIButton) {
        // they want to use meters not milimeters
        if (meters == true) {
            button.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            meters = false;
        } else if (meters == false) {
            button.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            meters = true;
        }
    }
    
    
    @IBAction func convertToImperial(_ button: UIButton) {
        if (metric) {
            button.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            metric = false;
            self.metricButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            self.unitsLabel.text = "Set all units to Feet";
        } else if (!metric) {
            button.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            metric = true;
            self.metricButton.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            self.unitsLabel.text = "Set all units to Meters";
        }
    }
    
    @IBAction func convertToMetric(_ button: UIButton) {
        if (!metric) {
            button.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            metric = true;
            self.imperialButton.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            self.unitsLabel.text = "Set all units to Meters";
        } else if (metric) {
            button.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            metric = false;
            self.imperialButton.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            self.unitsLabel.text = "Set all units to Feet";
            
        }
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
        self.timeTextField.resignFirstResponder();
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
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        //print(UIDevice.current.orientation.isLandscape);
        
    }

}

