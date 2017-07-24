//
//  Extensions.swift
//  Notes
//
//  Created by Alan Henrique Pégoli on 22/07/17.
//  Copyright © 2017 Alan Pégoli. All rights reserved.
//

import Foundation

extension String {
    
    func appendPathComponent(_ component: String) -> String {
        
        return (self as NSString).appendingPathComponent(component)
    }
    
}
