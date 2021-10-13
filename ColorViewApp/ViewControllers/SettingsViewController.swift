//
//  SettingsViewController.swift
//  ColorViewApp
//
//  Created by Ярослав Бойко on 06.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
// MARK: - IBOutlets
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
    
// MARK: - Public properties
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        mainView.layer.cornerRadius = 20
        mainView.backgroundColor = color
        
        setSliders(with: color)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTF, greenTF, blueTF)
    }
    
// MARK: - IBActions

    @IBAction func rgbAction(_ sender: UISlider) {
        mixColor()
        
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTF)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTF)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTF)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setNewColor(with: mainView.backgroundColor ?? .white)
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
                label.text = string(from: redSlider)
            case greenLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textfields: UITextField...) {
        textfields.forEach { textfield in
            switch textfield {
            case redTF:
                textfield.text = string(from: redSlider)
            case greenTF:
                textfield.text = string(from: greenSlider)
            default:
                textfield.text = string(from: blueSlider)
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
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let someText = textField.text else { return }
        
        if let floatValue = Float(someText) {
            switch textField {
            case redTF:
                redSlider.setValue(floatValue, animated: true)
                setValue(for: redLabel)
            case greenTF:
                greenSlider.setValue(floatValue, animated: true)
                setValue(for: greenLabel)
            default:
                blueSlider.setValue(floatValue, animated: true)
                setValue(for: blueLabel)
            }
            
            mixColor()
            return
        }
}
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        textField.inputAccessoryView = keyboardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

