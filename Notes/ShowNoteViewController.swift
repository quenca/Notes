//
//  ShowNoteViewController.swift
//  Notes
//
//  Created by Alan Henrique Pégoli on 22/07/17.
//  Copyright © 2017 Alan Pégoli. All rights reserved.
//

import UIKit

class ShowNoteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    
    var noteToShow: Note?
    var indexPath: Int?
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = noteToShow {
            self.navigationItem.title = note.title
            self.bodyTextView.text = note.body
        }
    }
    
    // MARK: - Actions
    
    @IBAction func deleteNote(_ sender: UIBarButtonItem) {
        
        let deleteAlert = UIAlertController(title: "Delete Note", message: "Are you sure you want to delete this note?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            if let noteToDelete = self.noteToShow {
                let filteredNotes = notes.filter { $0.date != noteToDelete.date }
                
                let array = serialize(filteredNotes)
                (array as NSArray).write(toFile: filePath, atomically: true)
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(yesAction)
        present(deleteAlert, animated: true)
    }
}
