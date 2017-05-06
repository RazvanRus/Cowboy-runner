//
//  GameManager.swift
//  Cowboy runner
//
//  Created by Rus Razvan on 05/05/2017.
//  Copyright © 2017 Rus Razvan. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager()
    private init() {}
    
    func setHighscore(highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: "Highscore")
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: "Highscore")
    }
}
