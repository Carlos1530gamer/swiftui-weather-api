//
//  DateExtension.swift
//  Weather Demo
//
//  Created by Carlos Daniel Hernandez Chauteco on 06/07/23.
//

import Foundation

extension Date {
    func getFormattedDate(timeZone: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .init(identifier: timeZone)
        formatter.dateFormat = "EEEE h:mm a"
        return formatter.string(from: self)
    }
}
