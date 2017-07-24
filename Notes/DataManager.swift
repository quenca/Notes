//
//  DataManager.swift
//  Notes
//
//  Created by Alan Henrique Pégoli on 23/07/17.
//  Copyright © 2017 Alan Pégoli. All rights reserved.
//

import Foundation

// MARK: - Properties

let dataManager = FileManager.default
let home = NSHomeDirectory()

let docsPath = home.appendPathComponent("Documents")
let filePath = docsPath.appendPathComponent("Notes.plist")

// MARK: - Serialization Methods

func serialize(_ arrayOfNotes: [Note]) -> [[String : String]] {
    
    var arrayOfDictionaries: [[String : String]] = []
    
    for item in arrayOfNotes {
        let title = item.title
        let body = item.body ?? ""
        let date = item.date
        
        arrayOfDictionaries.append(["Title" : title, "Body" : body, "Date" : date])
    }
    
    return arrayOfDictionaries
}

func deserialize(_ arrayOfDictionaries: [[String : String]]) -> [Note] {
    
    var arrayOfNotes: [Note] = []
    
    for item in arrayOfDictionaries {
        let title = item["Title"]
        let body = item["Body"]
        let date = item["Date"]
        
        let note = Note(title: title!, body: body, date: date!)
        
        arrayOfNotes.append(note)
    }
    
    return arrayOfNotes
}
