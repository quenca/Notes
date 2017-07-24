//
//  Note.swift
//  Notes
//
//  Created by Alan Henrique Pégoli on 23/07/17.
//  Copyright © 2017 Alan Pégoli. All rights reserved.
//

import Foundation

class Note {
    
    var title: String
    var body: String?
    var date: String

    init(title: String, body: String?) {
        
        let date = Date()
        let dateMask = DateFormatter()
        dateMask.dateFormat = "M/d/yy h:mm:ss a"
        
        self.title = title
        self.body = body
        self.date = dateMask.string(from: date)
    }
    
    init(title: String, body: String?, date: String) {
        
        self.title = title
        self.body = body
        self.date = date
    }
}
