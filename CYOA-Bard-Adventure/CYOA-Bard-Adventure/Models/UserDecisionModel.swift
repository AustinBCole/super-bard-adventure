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
    var currentActionNumber = 1
    
    let goodButtonsDictionary = ["scene1": "Go outside and fashion a torch", "scene2": "Try to door handle to open the door gently"  , "scene3": "Take the tapestry off the wall and cover the crow with it.", "scene4" : "Attack the goblin", "scene6" : "Grab the gems and make a hasty exit"]
    let badButtonsDictionary = ["scene1": "Continue walking deeper into the cave despite the darkness", "scene2": "Kick down the door with a mighty yell", "scene3": "Burn the tapestry with your torch", "scene4" : "Bow and compliment him on his home's fancy decour", "scene6" : "Rush out the door to take the remaining goblins by surprise"]
    let neutralButtonsDictionary = ["scene1": "Shout a greeting and hope someone does (or does not) respond", "scene2": "Look around for something else that is interesting"  , "scene3": "Take the tapestry off the wall and cover the woman with it", "scene4" : "Throw your rations at him and run", "scene6" : "Creep towards the door to try and get a peek around the corner", "scene10": ""]
    
    let goodButtonsBattleDictionary = ["action1" : "Attack the goblin from far away, using the superior reach of your spear", "action2" : "Finish the gobin off with a thrust of your spear", "action102" : "Finish the goblin off with a thrust of your spear"]
    let badButtonsBattleDictionary = ["action1" : "Rush the goblin and pin it against the wall", "action2" : "Rush the goblin and pin it against the wall", "action101" : "Rush the goblin and pin it against the wall", "action201" : "Throw down your spear and punch the goblin in the face"]
    let neutralButtonsBattleDictionary = ["action1" : "Keep the goblin at a distance and stay purely on the defensive", "action2" : "Keep the goblin at a distance and stay purely on the defensive", "action101" : "keep the goblin at a distance and stay purely on the defensive", "action10101" : "keep the goblin at a distance and stay purely on the defensive", "action20101" : "keep the goblin at a distance and stay purely on the defensive", "action30101" : "keep the goblin at a distance and stay purely on the defensive",  "action10001" : "keep the goblin at a distance and stay purely on the defensive", "action20001" : "keep the goblin at a distance and stay purely on the defensive", "action30001" : "keep the goblin at a distance and stay purely on the defensive", "action40001" : "keep the goblin at a distance and stay purely on the defensive", "action50001" : "keep the goblin at a distance and stay purely on the defensive", "action10002" : "keep the goblin at a distance and stay purely on the defensive", "action20002" : "keep the goblin at a distance and stay purely on the defensive", "action30002" : "keep the goblin at a distance and stay purely on the defensive", "action40002" : "keep the goblin at a distance and stay purely on the defensive", "action50002" : "keep the goblin at a distance and stay purely on the defensive" ]
    
    
    var bardHero: Person?
    var monster: Person?
    
    enum UserDecision {
        case good
        case bad
        case neutral
    }
    enum AmountOfDamageTaken {
        case small
        case medium
        case large
    }
    func healthPoints() -> String {
        guard let healthPoints = bardHero?.healthPoints else {return "Health Points: 5"}
        return "Health Points: \(String(healthPoints))"
    }
    
    func createHero (name: String) {
        guard let rationImage = UIImage(named: "pixel_cheese") else {return}
        guard let spearImage = UIImage(named: "short_spear_pixel") else{return}
        var spear = InventoryItem(name: "Spear", image: spearImage, quantity: 1)
        var ration = InventoryItem(name: "Ration", image: rationImage, quantity: 4)
        inventoryItems.append(spear)
        inventoryItems.append(ration)
        bardHero = Person(name: name, healthPoints: 5, isDead: false, inventory: inventoryItems)
    }
    func createMonster(name: String, health: Int) {
        monster = Person(name: name, healthPoints: health, isDead: false, inventory: nil)
    }
    func createItem(name: String, image: UIImage, quantity: Int) {
        let item = InventoryItem(name: name, image: image, quantity: quantity)
        inventoryItems.append(item)
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
    
    func changeGeneralSceneButtonTitles(condition: UserDecision) -> String {
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
    func changeActionSceneButtonTitles(condition: UserDecision) -> String {
        switch condition {
        case .good:
            guard let returnValue = goodButtonsBattleDictionary["action\(currentActionNumber)"] else {return "Could not get title"}
            return returnValue
        case .bad:
            guard let returnValue = badButtonsBattleDictionary["action\(currentActionNumber)"] else {return "Could not get title"}
            return returnValue
        case .neutral:
            guard let returnValue = neutralButtonsBattleDictionary["action\(currentActionNumber)"] else {return "Could not get title"}
            return returnValue
        }
        
    }
    
    func fetchText() -> String {
        var updatedData = ""
        guard let fileName = scene?.sceneName else {return ""}
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
    
    func heroHealth(damageTaken: AmountOfDamageTaken?) -> String {
        guard var heroHealth = bardHero?.healthPoints else {return "Could not get hero health"}
        guard let damageTaken = damageTaken else {return "HP: \(heroHealth)"}
        switch damageTaken {
        case .small:
            heroHealth -= 1
        case .medium:
            heroHealth -= 2
        case .large:
            heroHealth -= 3
        }
        bardHero?.healthPoints = heroHealth
        return "HP: \(heroHealth)"
    }
    
    func monsterHealth(damageTaken: AmountOfDamageTaken?) -> String {
        guard var monsterHealth = monster?.healthPoints else {return "Could not get monster health"}
        guard let damageTaken = damageTaken else {return "HP: \(monsterHealth)"}
        switch damageTaken {
        case .small:
            monsterHealth -= 1
        case .medium:
            monsterHealth -= 2
        case .large:
            monsterHealth -= 3
        }
        monster?.healthPoints = monsterHealth
        return "HP: \(monsterHealth)"
    }
}
