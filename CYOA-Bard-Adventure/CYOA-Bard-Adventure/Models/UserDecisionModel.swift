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
    var scene: Scene?
    var currentSceneNumber = 0
    
    let goodButtonsDictionary = ["scene1": "Go outside and fashion a torch", "scene2": "Try to door handle to open the door gently"  , "scene3": "Take the tapestry off the wall and cover the crow with it.", "scene4" : "Attack the goblin", "scene5" : ""]
    let badButtonsDictionary = ["scene1": "Continue walking deeper into the cave despite the darkness", "scene2": "Hello"  , "scene3": "Go outside and fashion a torch", "scene4" : "", "scene5" : ""]
    let neutralButtonsDictionary = ["scene1": "Shout a greeting and hope someone does (or does not) respond", "scene2": "Hello"  , "scene3": "Go outside and fashion a torch", "scene4" : "", "scene5" : ""]
    
    
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
    
    func changeScene(condition: UserDecision) -> Scene {
        switch condition {
        case .good:
            currentSceneNumber += 1
            let newSceneName = "scene\(currentSceneNumber)"
            let newScene = Scene(sceneName: newSceneName)
            return newScene
        case .bad:
            currentSceneNumber += 100
            let newSceneName = "scene\(currentSceneNumber)"
            let newScene = Scene(sceneName: newSceneName)
            return newScene
        case .neutral:
            currentSceneNumber += 1000
            let newSceneName = "scene\(currentSceneNumber)"
            let newScene = Scene(sceneName: newSceneName)
            return newScene
        }
    }
    
    func changeButtonTitles(condition: UserDecision) -> String {
        switch condition {
        case .good:
            guard let returnValue = goodButtonsDictionary["scene\(currentSceneNumber)"] else {return "Could not get title"}
            return returnValue
        case .bad:
            guard let returnValue = badButtonsDictionary["scene\(currentSceneNumber)"] else {return "Could not get title"}
            return returnValue
        case .neutral:
            guard let returnValue = neutralButtonsDictionary["scene\(currentSceneNumber)"] else {return "Could not get title"}
            return returnValue
        }
    
    }
    func fetchText() -> String {
        var updatedData = ""
        guard let fileName = scene?.sceneName else {return ""}
        print(fileName)
        print(currentSceneNumber)
        guard let path = Bundle.main.path(forResource: fileName, ofType: "text") else {return ""}
        do {
            let data = try String.init(contentsOfFile: path)
            guard let name = bardHero?.name else {return ""}
            updatedData = data.replacingOccurrences(of: "(mainCharacterName)", with: name)
        } catch {
            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
        }
        return updatedData
    }
}
