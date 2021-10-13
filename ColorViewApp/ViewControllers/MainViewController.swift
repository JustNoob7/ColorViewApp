//
//  MainViewController.swift
//  ColorViewApp
//
//  Created by Ярослав Бойко on 10.10.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(with color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.color = view.backgroundColor
        
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(with color: UIColor) {
        view.backgroundColor = color
    }
}
