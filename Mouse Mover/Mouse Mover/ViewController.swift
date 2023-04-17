//
//  ViewController.swift
//  Mouse Mover
//
//  Created by Admin on 17/04/2023.
//

import Cocoa

class ViewController: NSViewController {
    
    let mouseMover = MouseMover()

    private let distanceTextField: NSTextField = {
        let textField = NSTextField()
        textField.placeholderString = "Distance (in points)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let intervalTextField: NSTextField = {
        let textField = NSTextField()
        textField.placeholderString = "Interval (in seconds)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let startStopButton: NSButton = {
        let button = NSButton(title: "Enable", target: nil, action: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    deinit {
        self.mouseMover.stopMovingMouse()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        self.startStopButton.target = self
        self.startStopButton.action = #selector(self.startStopButtonClicked)
        
        self.view.addSubview(self.distanceTextField)
        self.view.addSubview(self.intervalTextField)
        self.view.addSubview(self.startStopButton)

        NSLayoutConstraint.activate([
            self.distanceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.distanceTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            self.distanceTextField.widthAnchor.constraint(equalToConstant: 150),

            self.intervalTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.intervalTextField.topAnchor.constraint(equalTo: self.distanceTextField.bottomAnchor, constant: 20),
            self.intervalTextField.widthAnchor.constraint(equalToConstant: 150),

            self.startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.startStopButton.topAnchor.constraint(equalTo: self.intervalTextField.bottomAnchor, constant: 20)
        ])
    }

    private func showAlert(title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc func startStopButtonClicked() {
        if let intervalValue = TimeInterval(self.intervalTextField.stringValue), let distanceValue = Int(self.distanceTextField.stringValue) {
            let distance = CGFloat(distanceValue)
            if startStopButton.title == "Enable" {
                self.mouseMover.startMovingMouse(interval: intervalValue, distance: distance)
                self.startStopButton.title = "Disable"
                
                if let appDelegate = NSApp.delegate as? AppDelegate {
                    appDelegate.updateMenuItemTitle(title: "Disable")
                }
                
                self.intervalTextField.isEnabled = false
                self.distanceTextField.isEnabled = false
            } else {
                self.mouseMover.stopMovingMouse()
                self.startStopButton.title = "Enable"
                
                if let appDelegate = NSApp.delegate as? AppDelegate {
                    appDelegate.updateMenuItemTitle(title: "Enable")
                }
                
                self.intervalTextField.isEnabled = true
                self.distanceTextField.isEnabled = true
            }
        } else {
            self.showAlert(title: "Error", message: "Please enter valid values for interval and distance.")
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
