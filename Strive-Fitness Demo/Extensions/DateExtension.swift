//
//  DateExtension.swift
//  Strive-Fitness Demo
//
//  Created by Rob Pee on 5/1/24.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
}
