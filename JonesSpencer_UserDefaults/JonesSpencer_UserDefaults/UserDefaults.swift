//  UserDefaults.swift
//  JonesSpencer_UserDefaults
//  Created by Spencer Jones on 4/22/24.

import Foundation
import UIKit

extension UserDefaults {
    // Save UIColor as data object
    func set(color: UIColor, forKey key:String) {
        
        // Convert UIColor into Data object by archiving
        let binaryData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        
        // Save binary data to UserDefaults
        self.set(binaryData, forKey: key)
    }
    
    // Get UIColor from saved defaults with key
    func color(forKey key: String) -> UIColor? {
        // Check for validData
        if let binaryData = data(forKey: key) {
            // Is Data UIColor
            if let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: binaryData) {
                // Return UIColor
                return color
            }
        }
        // If didn't return UIColor, something's wrong with data
        return nil
    }
}
