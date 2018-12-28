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
    var nextScene = "scene000001"
    var scene: Scene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        healthPointsLabel.text = UserDecisionModel.shared.healthPoints()
        if storyTextView.text.isEmpty {
            guard let path = Bundle.main.path(forResource: "scene1", ofType: "text") else{return}
            do {
                let data = try String.init(contentsOfFile: path)
                storyTextView.text = data
            } catch {
                NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
            }
            goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .good, scene: "scene1")), for: .normal)
            goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
            
            badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .bad, scene: "scene1")), for: .normal)
            badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
            
            neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .neutral, scene: "scene1")), for: .normal)
            neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
        }
    }
 
    @IBAction func goodDecisionButtonAction(_ sender: Any) {
        scene = UserDecisionModel.shared.changeScene(condition: .good, sceneNumber: currentSceneNumber )
        guard let fileName = scene?.sceneName else {return}

        guard let path = Bundle.main.path(forResource: fileName, ofType: "text") else{return}
        do {
        let data = try String.init(contentsOfFile: path)
            storyTextView.text = data
            return
        } catch {
            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
        }
        
        }
    
    @IBAction func badDecisionButtonAction(_ sender: Any) {
        scene = UserDecisionModel.shared.changeScene(condition: .bad, sceneNumber: currentSceneNumber )
        guard let fileName = scene?.sceneName else {return}
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "text") else{return}
        do {
            let data = try String.init(contentsOfFile: path)
            storyTextView.text = data
            return
        } catch {
            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
        }
    }
    @IBAction func neutralDecisionButtonAction(_ sender: Any) {
        scene = UserDecisionModel.shared.changeScene(condition: .neutral, sceneNumber: currentSceneNumber )
        guard let fileName = scene?.sceneName else {return}
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "text") else{return}
        print(path)
        do {
            let data = try String.init(contentsOfFile: path)
            storyTextView.text = data
            return
        } catch {
            NSLog("Error Decoding text from scene file. GeneralSceneViewController.goodDecisionButtonAction")
        }
    }
    
    
    
}
