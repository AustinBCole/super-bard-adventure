//
//  BattleSceneViewController.swift
//  CYOA-Bard-Adventure
//
//  Created by Austin Cole on 12/29/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import UIKit

class BattleSceneViewController: UIViewController {
    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var monsterNameLabel: UILabel!
    @IBOutlet weak var monsterHealthPointsLabel: UILabel!
    @IBOutlet weak var heroHeroView: UIImageView!
    @IBOutlet weak var herNameLabel: UILabel!
    @IBOutlet weak var heroHealthPointsLabel: UILabel!
    @IBOutlet weak var goodDecisionButton: UIButton!
    @IBOutlet weak var badDecisionButton: UIButton!
    @IBOutlet weak var neutralDecisionButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDecisionModel.shared.createMonster(name: "Goblin", health: 3)
        monsterHealthPointsLabel.text = "\(UserDecisionModel.shared.monsterHealth(damageTaken: nil))"
        herNameLabel.text = UserDecisionModel.shared.bardHero?.name
        heroHealthPointsLabel.text = "\(UserDecisionModel.shared.heroHealth(damageTaken: nil))"
        goodDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .good)), for: .normal)
        goodDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        badDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .bad)), for: .normal)
        badDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        neutralDecisionButton.setAttributedTitle(NSAttributedString(string: UserDecisionModel.shared.changeActionSceneButtonTitles(condition: .neutral)), for: .normal)
        neutralDecisionButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func goodDecisionButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func badDecisionButtonAction(_ sender: Any) {
    }
    
    @IBAction func neutralDecisionButtonAction(_ sender: Any) {
    }
}
