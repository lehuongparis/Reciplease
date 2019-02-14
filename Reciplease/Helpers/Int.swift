//
//  Int.swift
//  Reciplease
//
//  Created by AMIMOBILE on 04/02/2019.
//  Copyright © 2019 lehuong. All rights reserved.
//

import Foundation

extension Int {
    var timeInHoursandMinutes: String {
        get {
            let hours = self/3600
            let minutes = (self / 60) % 60
            let timeInHoursandMinutes = String(format: "%01i:%02i", hours, minutes)
            return timeInHoursandMinutes
        }
    }
}
