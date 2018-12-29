//
//  UserDecision.swift
//  CYOA-Bard-Adventure
//
//  Created by Austin Cole on 12/27/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class UserDecisionModel {
    //MARK: Singleton
    static let shared = UserDecisionModel()
    private init() {}
    let generalSceneVC = GeneralSceneViewController()
    var inventoryItems: [InventoryItem] = []
    
    let goodButtonsDictionary = ["scene1": "Go outside and fashion a torch", "scene2": "Hello"  , "scene3": "Go outside and fashion a torch"]
    let badButtonsDictionary = ["scene1": "Continue walking deeper into the cave despite the darkness", "scene2": "Hello"  , "scene3": "Go outside and fashion a torch"]
    let neutralButtonsDictionary = ["scene1": "Shout a greeting and hope someone does (or does not) respond", "scene2": "Hello"  , "scene3": "Go outside and fashion a torch"]
    
    var bardHero: Person?
    
    enum UserDecision {
        case good
        case bad
        case neutral
    }
    
    func healthPoints() -> String {
        guard let healthPoints = bardHero?.healthPoints else {return "Health Points: 5"}
        return "Health Points: \(String(healthPoints))"
    }
    
    func createHero (name: String) {
        guard let spearImage = UIImage(named: "short_spear_pixel") else{return}
        var spear = InventoryItem(name: "Spear", image: spearImage, quantity: 1)
        inventoryItems.append(spear)
        bardHero = Person(name: name, healthPoints: 5, inventory: inventoryItems)
    }
    
    func changeScene(condition: UserDecision, sceneNumber: Int) -> Scene {
        switch condition {
        case .good:
            let newSceneName = "scene\(sceneNumber + 1)"
            let newScene = Scene(sceneName: newSceneName)
            return newScene
        case .bad:
            let newSceneName = "scene\(sceneNumber + 100)"
            let newScene = Scene(sceneName: newSceneName)
            return newScene
        case .neutral:
            let newSceneName = "scene\(sceneNumber + 10000)"
            let newScene = Scene(sceneName: newSceneName)
            return newScene
        }
    }
    
    func changeButtonTitles(condition: UserDecision, scene: String) -> String {
        switch condition {
        case .good:
            guard let returnValue = goodButtonsDictionary["\(scene)"] else {return "Could not get title"}
            return returnValue
        case .bad:
            guard let returnValue = badButtonsDictionary["\(scene)"] else {return "Could not get title"}
            return returnValue
        case .neutral:
            guard let returnValue = neutralButtonsDictionary["\(scene)"] else {return "Could not get title"}
            return returnValue
        }
    
    }
}
