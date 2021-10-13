//
//  SettingsViewController.swift
//  ColorViewApp
//
//  Created by Ярослав Бойко on 06.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        mainView.layer.cornerRadius = 20
//        mainView.backgroundColor = color
        
        setSliders(with: color)
        
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTF, greenTF, blueTF)
    }
    
// MARK: - IBActions
    
    @IBAction func rgbAction(_ sender: UISlider) {
        mixColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: sender)
            redTF.text = string(from: sender)
        case greenSlider:
            greenLabel.text = string(from: sender)
            greenTF.text = string(from: sender)
        default:
            blueLabel.text = string(from: sender)
            blueTF.text = string(from: sender)
        }
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.setNewColor(with: mainView.backgroundColor ?? .blue)
        dismiss(animated: true)
    }
    
// MARK: - Private Methods
    
    private func mixColor() {
        mainView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textfields: UITextField...) {
        textfields.forEach { textfield in
            switch textfield {
            case redTF:
                redTF.text = string(from: redSlider)
            case greenTF:
                greenTF.text = string(from: greenSlider)
            default:
                blueTF.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setSliders(with color: UIColor) {
        let someColor = CIColor(color: color)
        
        redSlider.value = Float(someColor.red)
        greenSlider.value = Float(someColor.green)
        blueSlider.value = Float(someColor.blue)
    }
    
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let someText = textField.text else { return }
        guard let floatValue = Float(someText) else { return }
        
        switch textField {
        case redTF:
            redSlider.value = floatValue
            redLabel.text = someText
            rgbAction(redSlider)
        case greenTF:
            greenSlider.value = floatValue
            greenLabel.text = someText
            rgbAction(greenSlider)
        default:
            blueSlider.value = floatValue
            blueLabel.text = someText
            rgbAction(blueSlider)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let someText = textField.text else { return false }
        guard let floatValue = Float(someText) else { return false }
        
        switch textField {
        case redTF:
            redSlider.value = floatValue
            redLabel.text = someText
            rgbAction(redSlider)
        case greenTF:
            greenSlider.value = floatValue
            greenLabel.text = someText
            rgbAction(greenSlider)
        default:
            blueSlider.value = floatValue
            blueLabel.text = someText
            rgbAction(blueSlider)
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

