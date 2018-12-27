//
//  UserDecision.swift
//  CYOA-Bard-Adventure
//
//  Created by Austin Cole on 12/27/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import Foundation

class UserDecisionModel {
    //MARK: Singleton
    static let shared = UserDecisionModel()
    private init() {}
    
    var bardHero: Person?
    
    func createHero (name: String) {
        bardHero = Person(name: name, healthPoints: 5)
    }
    
}
