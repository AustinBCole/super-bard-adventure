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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDecisionModel.shared.currentSceneNumber)
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .good)
        print(UserDecisionModel.shared.scene)
        DispatchQueue.main.async {
            self.healthPointsLabel.text = UserDecisionModel.shared.healthPoints()
            self.storyTextView.text = UserDecisionModel.shared.fetchText()
            self.updateButtons()
        }
        
        // Do any additional setup after loading the view.
        }
    func updateButtons() {
        goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeGeneralSceneButtonTitles(condition: .good)), for: .normal)
        print(UserDecisionModel.shared.changeGeneralSceneButtonTitles(condition: .good))
        goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeGeneralSceneButtonTitles(condition: .bad)), for: .normal)
        badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeGeneralSceneButtonTitles(condition: .neutral)), for: .normal)
        neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
 
    @IBAction func goodDecisionButtonAction(_ sender: Any) {
        if UserDecisionModel.shared.scene?.sceneName == "scene1" {
            guard let torchImage = UIImage(named: "pixel_torch") else {return}
            UserDecisionModel.shared.createItem(name: "Torch", image: torchImage, quantity: 1)
        }
        if UserDecisionModel.shared.scene?.sceneName == "scene7" {
            guard let gemImage = UIImage(named: "orage_gem_pixel") else {return}
            UserDecisionModel.shared.createItem(name: "Gem", image: gemImage, quantity: 7)
        }
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .good)
        storyTextView.text = UserDecisionModel.shared.fetchText()
        updateButtons()
        gameOverScreen()
        
    }
    
    @IBAction func badDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .bad)
        storyTextView.text = UserDecisionModel.shared.fetchText()
        updateButtons()
        gameOverScreen()
    }
    @IBAction func neutralDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .neutral)
        storyTextView.text = UserDecisionModel.shared.fetchText()
        updateButtons()
        gameOverScreen()
    }
    
    func gameOverScreen() {
        if storyTextView.text.contains("You are dead.") {
            goodDecisionButton.isHidden = true
            badDecisionButton.isHidden = true
            neutralDecisionButton.isHidden = true
            healthPointsLabel.text = "Health Points: 0"
        }
        else if storyTextView.text.contains("You have won the game!") {
            goodDecisionButton.isHidden = true
            badDecisionButton.isHidden = true
            neutralDecisionButton.isHidden = true
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "battleSegue" {
            if UserDecisionModel.shared.currentSceneNumber != 5 {
                return false
            }
        }
        return true
    }
}
