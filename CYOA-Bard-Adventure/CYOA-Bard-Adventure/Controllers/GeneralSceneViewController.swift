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
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .good)
        DispatchQueue.main.async {
            self.healthPointsLabel.text = UserDecisionModel.shared.healthPoints()
            self.storyTextView.text = UserDecisionModel.shared.fetchText()
            print(UserDecisionModel.shared.fetchText())
            self.updateButtons()
        }
        
        // Do any additional setup after loading the view.
        }
    func updateButtons() {
        if UserDecisionModel.shared.currentSceneNumber == 6 {
        }
        goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .good)), for: .normal)
        goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .bad)), for: .normal)
        badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeButtonTitles(condition: .neutral)), for: .normal)
        neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
 
    @IBAction func goodDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .good)
        storyTextView.text = UserDecisionModel.shared.fetchText()
        updateButtons()
        
    }
    
    @IBAction func badDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .bad)
        storyTextView.text = UserDecisionModel.shared.fetchText()
        updateButtons()
    }
    @IBAction func neutralDecisionButtonAction(_ sender: Any) {
        UserDecisionModel.shared.scene = UserDecisionModel.shared.changeScene(condition: .neutral)
        storyTextView.text = UserDecisionModel.shared.fetchText()
        updateButtons()
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
