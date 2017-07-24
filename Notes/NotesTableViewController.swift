//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Alan Henrique Pégoli on 22/07/17.
//  Copyright © 2017 Alan Pégoli. All rights reserved.
//

import UIKit

var notes: [Note] = []

class NotesTableViewController: UITableViewController {
    
    // MARK: - ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNotes()
        self.tableView.reloadData()
    }
    
    // MARK: - Methods
    
    func fetchNotes() {
        
        if let savedNotes = NSArray(contentsOfFile: filePath) {
            notes = deserialize(savedNotes as! Array)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func home(_ sender: UIStoryboardSegue) {}

    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].date

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNote", sender: notes[indexPath.row])
    }
    
    // MARK: - UIStoryboardSegue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote" {
            let showNoteViewController = segue.destination as! ShowNoteViewController
            showNoteViewController.noteToShow = sender as? Note
        }
    }
}
