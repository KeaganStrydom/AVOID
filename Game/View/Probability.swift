//
//  Probability.swift
//  Game
//
//  Created by Keagan Strydom on 2018/07/21.
//  Copyright © 2018 Lighthouse. All rights reserved.
//

import UIKit

struct OddsRange {
    var lower : Int
    var upper : Int
}

struct Probability {
    private init() {}
    static public func inOdds(_ number : Int, oddsRange : CountableClosedRange<Int>) -> Bool{
        return oddsRange.contains(number)
    }
}

struct Random {
    private init() {}
    static public func generateNumber(between lowerbound: Int, and upperbound: Int) -> Int {
        let randomNumber = Int(arc4random_uniform(UInt32(upperbound - lowerbound + 1))) + lowerbound
        return randomNumber
    }
}



