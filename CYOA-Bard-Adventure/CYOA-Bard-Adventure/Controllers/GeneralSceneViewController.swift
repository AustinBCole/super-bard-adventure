//
//  GeneralSceneViewController.swift
//  CYOA-Bard-Adventure
//
//  Created by Austin Cole on 12/27/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class GeneralSceneViewController: UIViewController {
    @IBOutlet weak var healthPointsLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var goodDecisionButton: UIButton!
    @IBOutlet weak var badDecisionButton: UIButton!
    @IBOutlet weak var neutralDecisionButton: UIButton!
    
    var currentSceneNumber = 000001
    var scene: Scene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthPointsLabel.text = UserDecisionModel.shared.healthPoints()
        if storyTextView.text.isEmpty {
            guard let path = Bundle.main.path(forResource: "scene1", ofType: "text") else{return}
            do {
                let data = try String.init(contentsOfFile: path)
                guard let name = UserDecisionModel.shared.bardHero?.name else {return}
                let updatedData = data.replacingOccurrences(of: "(mainCharacterName)", with: name)
                storyTextView.text = updatedData
            } catch {
                NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
            }
            updateButtons()
        // Do any additional setup after loading the view.
        }
    }
    func updateButtons() {
        goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .good, sceneNumber: currentSceneNumber)), for: .normal)
        goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        print(currentSceneNumber)
        print(UserDecisionModel.shared.changeButtonTitles(condition: .good, sceneNumber: currentSceneNumber))
        
        badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .bad, sceneNumber: currentSceneNumber)), for: .normal)
        badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .neutral, sceneNumber: currentSceneNumber)), for: .normal)
        neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
 
    @IBAction func goodDecisionButtonAction(_ sender: Any) {
        currentSceneNumber += 1
        scene = UserDecisionModel.shared.changeScene(condition: .good, sceneNumber: currentSceneNumber )
        guard let fileName = scene?.sceneName else {return}
        print(currentSceneNumber)
        guard let path = Bundle.main.path(forResource: fileName, ofType: "text") else{return}
        do {
        let data = try String.init(contentsOfFile: path)
            guard let name = UserDecisionModel.shared.bardHero?.name else {return}
            let updatedData = data.replacingOccurrences(of: "(mainCharacterName)", with: name)
            storyTextView.text = updatedData
        } catch {
            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
        }
        updateButtons()
    }
    
    @IBAction func badDecisionButtonAction(_ sender: Any) {
        currentSceneNumber += 100
        scene = UserDecisionModel.shared.changeScene(condition: .bad, sceneNumber: currentSceneNumber )
        guard let fileName = scene?.sceneName else {return}
        guard let path = Bundle.main.path(forResource: fileName, ofType: "text") else{return}
        do {
            let data = try String.init(contentsOfFile: path)
            guard let name = UserDecisionModel.shared.bardHero?.name else {return}
            let updatedData = data.replacingOccurrences(of: "(mainCharacterName)", with: name)
            storyTextView.text = updatedData
        } catch {
            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
        }
        updateButtons()
    }
    @IBAction func neutralDecisionButtonAction(_ sender: Any) {
        currentSceneNumber += 10000
        scene = UserDecisionModel.shared.changeScene(condition: .neutral, sceneNumber: currentSceneNumber )
        guard let fileName = scene?.sceneName else {return}
        guard let path = Bundle.main.path(forResource: fileName, ofType: "text") else{return}
        print(path)
        do {
            let data = try String.init(contentsOfFile: path)
            guard let name = UserDecisionModel.shared.bardHero?.name else {return}
            let updatedData = data.replacingOccurrences(of: "(mainCharacterName)", with: name)
            storyTextView.text = updatedData
            return
        } catch {
            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
        }
        updateButtons()
    }
}
