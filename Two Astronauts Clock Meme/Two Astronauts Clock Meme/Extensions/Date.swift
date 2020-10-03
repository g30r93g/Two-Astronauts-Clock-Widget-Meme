//
//  Date.swift
//  Two Astronauts Clock Meme
//
//  Created by George Nick Gorzynski on 03/10/2020.
//

import Foundation

extension Date {

    var zeroSeconds: Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)
    }

}
