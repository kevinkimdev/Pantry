//
//  ViewController.swift
//  StorageExample
//
//  Created by Nick O'Neill on 11/4/15.
//  Copyright © 2015 That Thing in Swift. All rights reserved.
//

import UIKit
import Pantry

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var persistTextField: UITextField! {
        didSet {
            persistTextField.text = autopersist
        }
    }

    var autopersist: String? {
        set {
            if let newValue = newValue {
                Pantry.pack(newValue, key: "autopersist")
                persistTextField.text = newValue
            }
        }
        get {
            return Pantry.unpack("autopersist")
        }
    }

    @IBAction func saveText() {
        if let text = textField.text , !text.isEmpty {
            Pantry.pack(text, key: "saved_text")
            textField.text = ""
            print("Stored text")
        }
    }
    
    @IBAction func loadText() {
        if let unpackedText: String = Pantry.unpack("saved_text") {
            textField.text = unpackedText
            print("Loaded text")
        }
    }

    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            autopersist = "first"
        case 1:
            autopersist = "second"
        case 2:
            autopersist = "third"
        default:
            break
        }
    }
}

