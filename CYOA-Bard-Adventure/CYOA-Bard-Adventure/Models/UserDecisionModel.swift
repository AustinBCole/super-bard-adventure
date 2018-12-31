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
    
    func changeButtonTitles(condition: UserDecision, sceneNumber: Int) -> String {
        switch condition {
        case .good:
            guard let returnValue = goodButtonsDictionary["scene\(sceneNumber)"] else {return "Could not get title"}
            return returnValue
        case .bad:
            guard let returnValue = badButtonsDictionary["scene\(sceneNumber)"] else {return "Could not get title"}
            return returnValue
        case .neutral:
            guard let returnValue = neutralButtonsDictionary["scene\(sceneNumber)"] else {return "Could not get title"}
            return returnValue
        }
    
    }
//    func fetchText() {
//        guard let path = Bundle.main.path(forResource: "scene\(currentSceneNumber)", ofType: "text") else {return}
//        do {
//            let data = try String.init(contentsOfFile: path)
//            guard let name = UserDecisionModel.shared.bardHero?.name else {return}
//            let updatedData = data.replacingOccurrences(of: "(mainCharacterName)", with: name)
//            storyTextView.text = updatedData
//        } catch {
//            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
//        }
//    }
}
