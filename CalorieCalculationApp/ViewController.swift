//
//  ViewController.swift
//  CalorieCalculationApp
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBAction func endKey(_ sender: Any) {
        if exerciseView.isHidden == false {
            exerciseView.isHidden = true
        }
        view.endEditing(true)
    }
    
    let exercise = ["幾乎不動","稍微運動(每周1-3次)","中度運動(每周3-5次)","積極運動(每周6-7次)","專業運動(2倍運動量)"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercise.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exercise[row]
    }
    @IBOutlet weak var exercisePickerView: UIPickerView!
    

    

    @IBOutlet weak var exerciseView: UIView!
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var exerciseText: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBAction func exerciseButton(_ sender: Any) {
        exerciseView.isHidden = false
        view.endEditing(true)
    }
    @IBAction func doneButton(_ sender: Any) {
        let exerciseSelection = exercise[exercisePickerView.selectedRow(inComponent: 0)]
        
        exerciseText.setTitle(exerciseSelection, for: .normal)
        exerciseView.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var BMRLabel: UILabel!
    @IBOutlet weak var suggestLabel: UILabel!
    
    @IBAction func calculate(_ sender: Any) {
        view.endEditing(true)
        if let gender = genderSegmented.titleForSegment(at: genderSegmented.selectedSegmentIndex),let height = heightTextField.text,let weight = weightTextField.text,let age = ageTextField.text,let exerciseSelection = exerciseText.titleLabel?.text{
            var demandCalories : Int?
            var BMR : Double?
            if weight != "",height != "",age != ""{
                if gender == "男"{
                    BMR = 66 + 13.7 * Double(weight)! + 5 * Double(height)! - 6.8 * Double(age)!
                } else {
                    BMR = 655 + 9.6 * Double(weight)! + 1.8 * Double(height)! - 4.7 * Double(age)!
                                    }
                switch exerciseSelection {
                case "幾乎不動" :
                    demandCalories = Int(BMR! * 1.2)
                case "稍微運動(每周1-3次)" :
                    demandCalories = Int(BMR! * 1.375)
                case "中度運動(每周3-5次)" :
                    demandCalories = Int(BMR! * 1.55)
                case "積極運動(每周6-7次)" :
                    demandCalories = Int(BMR! * 1.725)
                case "專業運動(2倍運動量)":
                    demandCalories = Int(BMR! * 1.9)
                default :
                    warningLabel.isHidden = false
                }
                if let demandCalories = demandCalories {
                    BMRLabel.text = "\(Int(BMR!)) 大卡"
                    calorieLabel.text = "\(demandCalories) 大卡"
                    suggestLabel.text = "\(Int(BMR!)) 大卡<建議攝取量<\(demandCalories) 大卡"
                    warningLabel.isHidden = true
                }
                
            } else {
                warningLabel.isHidden = false
            }
            
        }

        
    }
    
}

