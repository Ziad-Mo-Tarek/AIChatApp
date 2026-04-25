//
//  Date+EXT.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 25/04/2026.
//

import Foundation

extension Date {
    func adding(days: Int = 0, hours: Int = 0, minutes: Int = 0) -> Date {
        let totalSeconds =
        (days * 24 * 60 * 60) +
        (hours * 60 * 60) +
        (minutes * 60)
        
        return self.addingTimeInterval(TimeInterval(totalSeconds))
    }
}
