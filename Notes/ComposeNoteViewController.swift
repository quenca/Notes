//
//  ComposeNoteViewController.swift
//  Notes
//
//  Created by Alan Henrique Pégoli on 22/07/17.
//  Copyright © 2017 Alan Pégoli. All rights reserved.
//

import UIKit

class ComposeNoteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    let placeholder: String = "Write your note here..."
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    // MARK: - Methods
    
    func setUp() {
        self.titleTextField.delegate = self
        self.bodyTextView.delegate = self

        setUpTextView(atStart: true)
        
        self.titleTextField.becomeFirstResponder()
    }
    
    func setUpTextView(atStart: Bool) {
        if atStart {
            self.bodyTextView.textColor = UIColor.lightGray
            self.bodyTextView.text = placeholder
        } else {
            self.bodyTextView.textColor = UIColor.black
            self.bodyTextView.text = ""
        }
    }
    
    func presentAlert() {
        let emptyTitleAlert = UIAlertController(title: "Empty Field", message: "You can't leave Title empty", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.titleTextField.becomeFirstResponder()
        }
        emptyTitleAlert.addAction(okayAction)
        present(emptyTitleAlert, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        
        if bodyTextView.text == placeholder {
            self.bodyTextView.text = nil
        }
        
        let note = Note(title: titleTextField.text!, body: bodyTextView.text)
        notes.insert(note, at: 0)
        
        let array = serialize(notes)
        (array as NSArray).write(toFile: filePath, atomically: true)
    
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UIResponder
extension ComposeNoteViewController {
    override var canBecomeFirstResponder: Bool{
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension ComposeNoteViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty == true {
            presentAlert()
        } else {
            self.bodyTextView.becomeFirstResponder()
        }
        return true
    }
}

// MARK: - UITextViewDelegate
extension ComposeNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.titleTextField.text?.isEmpty == true {
            presentAlert()
        } else {
            if textView.text == placeholder {
                setUpTextView(atStart: false)
            }
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setUpTextView(atStart: true)
        }
    }
}
